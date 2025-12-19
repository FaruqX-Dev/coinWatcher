import 'package:flutter/material.dart';

enum PasswordStrength { weak, medium, strong }

class PasswordStrengthWidget extends StatelessWidget {
  final String password;

  const PasswordStrengthWidget({
    super.key,
    required this.password,
  });

  PasswordStrength _calculateStrength(String value) {
    int score = 0;

    if (value.length >= 6) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[!@#\$&*~]').hasMatch(value)) score++;

    if (score <= 1) return PasswordStrength.weak;
    if (score == 2 || score == 3) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final strength = _calculateStrength(password);

    Color color;
    String label;
    double value;

    switch (strength) {
      case PasswordStrength.weak:
        color = Colors.red;
        label = 'Weak';
        value = 0.33;
        break;
      case PasswordStrength.medium:
        color = Colors.orange;
        label = 'Medium';
        value = 0.66;
        break;
      case PasswordStrength.strong:
        color = Colors.green;
        label = 'Strong';
        value = 1.0;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        LinearProgressIndicator(
          value: value,
          color: color,
          backgroundColor: color.withValues(alpha: 0.2),
          minHeight: 6,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Password Strength: ',style: TextStyle(color: color),),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
