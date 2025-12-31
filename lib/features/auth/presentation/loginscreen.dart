import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/utils/screensize.dart';
import 'package:coin_watcher/features/auth/presentation/signup_screen.dart';
import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../coin_data/presentation/coin_screen_list.dart';
import 'forgot_password.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hidetext = true;
  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authcontrollerProvider);

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
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 43, 99, 48),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/cwatch_logo.png'),
                        ),
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
                  Text('Enter your details to continue'),
                  SizedBox(height: ScreenSize.height(context) * .05),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: _hidetext,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
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
                          style: TextStyle(color: AppTheme.buttonColors),
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
                          const SnackBar(
                              content: Text('Logged in Successfully')),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CoinScreenList()),
                        );

                        emailController.clear();
                        passwordController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign in failed: $e')),
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
                      Text('OR'),
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
                    onTap: () {},
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
                              Icon(Icons.g_mobiledata, size: 25),
                              Text(
                                'Continue with google',
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
