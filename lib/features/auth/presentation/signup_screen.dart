import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/utils/screensize.dart';
import 'package:coin_watcher/core/widget/mydrawer.dart';
import 'package:coin_watcher/features/auth/presentation/loginscreen.dart';
import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/password_strength.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidetext = true;
  bool _terms = false;
  String _password = '';

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
                      ClipRRect(
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
                    ],
                  ),
                  SizedBox(height: ScreenSize.height(context) * .02),
                  Row(
                    children: [
                      Text(
                        'Create Your Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
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
                        color: isDarkModeOn ? Colors.white : Colors.white),
                    decoration: InputDecoration(
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey),
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
                    cursorColor: isDarkModeOn ? Colors.white : Colors.white,
                    style: TextStyle(
                        color: isDarkModeOn ? Colors.white : Colors.white),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: _hidetext,
                    decoration: InputDecoration(
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
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
                  PasswordStrengthWidget(password: _password),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                              checkColor:
                                  isDarkModeOn ? Colors.white : Colors.white,
                              value: _terms,
                              onChanged: (bool? checked) {
                                setState(() {
                                  _terms = checked ?? false;
                                });
                              },
                            ),
                            Text('I agree to ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkModeOn
                                        ? Colors.white
                                        : Colors.white)),
                            InkWell(
                              enableFeedback: true,
                              onTap: () async {
                                final url = Uri.parse('https://www.termsfeed.com/live/f3a59e67-b88d-4355-bd5b-971855aa6272');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Could not launch URL')),
                                  );
                                }
                              },
                              child: Text(
                                'Terms & conditions',
                                style: TextStyle(color: AppTheme.buttonColors),
                              ),
                            ),
                            Text(' and ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkModeOn
                                        ? Colors.white
                                        : Colors.white)),
                            InkWell(
                              enableFeedback: true,
                              onTap: () => showPrivacyPolicy(context),
                              child: Text(
                                'Privacy Policy.',
                                style: TextStyle(color: AppTheme.buttonColors),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height(context) * .28),
                  GestureDetector(
                    // ... inside SignupScreen GestureDetector onTap ...
                    onTap: () async {
                      if (!_terms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please accept the terms and conditions')),
                        );
                        return;
                      }

                      try {
                        await ref.read(authcontrollerProvider).signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registered Successfully!'),
                            backgroundColor: Colors.green.shade400,
                          ),
                        );

                        // This removes the Signup screen and lets AuthGate show the Dashboard
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Sign up failed: $e'),
                              backgroundColor: Colors.red.shade400),
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
                            'Sign Up',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Log in',
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

void showTermsAndConditions(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Terms & Conditions'),
      content: Column(
        children: [
          const Text(
              "By using this app, you agree to our terms and conditions.\n"),
          Text(
              "Privacy PolicyLast updated:January 02, 2026\nThis Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.")
        ],
      ),
    ),
  );
}
