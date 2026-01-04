import 'dart:async';

import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/theme.dart';
import '../../../core/utils/screensize.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isCooldownActive = false;
  int _cooldownSeconds = 25;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkEmailField);
  }

  @override
  void dispose() {
    emailController.removeListener(_checkEmailField);
    _timer?.cancel();
    super.dispose();
  }

  void _checkEmailField() {
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty && !_isCooldownActive;
    });
  }

  void _startCooldown() {
    setState(() {
      _isCooldownActive = true;
      _isButtonEnabled = false;
      _cooldownSeconds = 25;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _cooldownSeconds--;
        if (_cooldownSeconds <= 0) {
          _isCooldownActive = false;
          _isButtonEnabled = emailController.text.isNotEmpty;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _authController = ref.watch(authcontrollerProvider);
        final isDarkModeOn = ref.watch(isThemeDarkModeProvider);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppTheme.appBackgroundColor,
              leading: BackButton(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppTheme.appBackgroundColor,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/lock.png', scale: 1.5),
                        Text(
                          'Forgot Password?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          style: TextStyle(
                            color: isDarkModeOn ? Colors.white : Colors.white
                          ),
                          textAlign: TextAlign.center,
                          "Don't worry, it happens. Enter the email address \nlinked to your account to reset the \npassword.",
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(
                      color: isDarkModeOn ? Colors.white : Colors.white
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'name@example.com',
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.mail, color: Colors.grey),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  enableFeedback: _isButtonEnabled,
                  onTap: _isButtonEnabled ? () async {
                    await _authController.resetPassword(
                      emailController.text.trim(),
                    );
                    _startCooldown();
                  } : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: ScreenSize.width(context) * .9,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isButtonEnabled ? AppTheme.buttonColors : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _isCooldownActive ? 'Resend in ${_cooldownSeconds}s' : 'Send Reset Link',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.constantTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Remember your password ?', style:
                        TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(color: AppTheme.buttonColors),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
