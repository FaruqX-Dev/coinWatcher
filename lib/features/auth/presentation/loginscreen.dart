import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/utils/screensize.dart';
import 'package:coin_watcher/features/auth/presentation/signup_screen.dart';
import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'forgot_password.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hidetext = true;

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authcontrollerProvider);
    final isDarkModeOn = ref.watch(isThemeDarkModeProvider);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppTheme.appBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: ScreenSize.height(context) * .05),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(30),
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(255, 43, 99, 48),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, right: 11, bottom: 8),
                                  child: Image.asset(
                                      'assets/images/cwatch_logo.png'),
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height(context) * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height(context) * .01),
                  Text(
                    'Enter your details to continue',
                    style: TextStyle(
                        color: isDarkModeOn ? Colors.white : Colors.white),
                  ),
                  SizedBox(height: ScreenSize.height(context) * .05),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            color: isDarkModeOn ? Colors.white : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: isDarkModeOn ? Colors.white : Colors.white,
                    style: TextStyle(
                        color: isDarkModeOn ? Colors.white : Colors.white,
                        fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.mail, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                            color: isDarkModeOn ? Colors.white : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: _hidetext,
                    cursorColor: isDarkModeOn ? Colors.white : Colors.white,
                    style: TextStyle(
                        color: isDarkModeOn ? Colors.white : Colors.white,
                        fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      fillColor: isDarkModeOn ? Colors.white : Colors.white,
                      focusColor: isDarkModeOn ? Colors.white : Colors.white,
                      
                      hintStyle: TextStyle(color: Colors.grey),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _hidetext = !_hidetext;
                          });
                        },
                        child: Icon(
                          _hidetext ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: AppTheme.buttonColors, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    enableFeedback: true,
                     onTap: () async {
                try {
                  await authController.signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged in successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed: $e')),
                  );
                }
              },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: ScreenSize.width(context) * .9,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppTheme.buttonColors,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: AppTheme.constantTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenSize.width(context) * .4,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                            color: isDarkModeOn ? Colors.white : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: ScreenSize.width(context) * .4,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    enableFeedback: true,
                    onTap: () async {
                      try {
                        await authController.signInAsGuest();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signed in as guest')),
                        );
                        // Navigate back to AuthGate
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Guest sign-in failed: $e')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: ScreenSize.width(context) * .9,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 25, 51, 26),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 25,
                                color: Colors.white,
                              ),
                              Text(
                                'Sign in as Guest',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.buttonColors,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
