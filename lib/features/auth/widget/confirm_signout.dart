import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

class ConfirmSignout extends ConsumerWidget {
  const ConfirmSignout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authcontrollerProvider);
    final authState = ref.watch(currentUserProvider);
    final user=authState.value;
    final bool isUserLoggedIn = user != null && !user.isAnonymous;
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isUserLoggedIn?
              Text(
                'Are you sure you want to sign out ?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ):Text('Return to Login',
               style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              SizedBox(
                height: 20,
              ),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
  try {
    // Trigger sign out
    await authController.signOut();
    ref.invalidate(authStateProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed Out successfully')),
    );
    if (context.mounted) {
      Navigator.of(context).pop(); 
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
},
                    child: Text('Yes'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
