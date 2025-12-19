import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/utils/screensize.dart';
import 'package:coin_watcher/features/auth/presentation/loginscreen.dart';
import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:coin_watcher/features/coin_data/presentation/coin_screen_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final authController = ref.watch(authcontrollerProvider);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppTheme.appBackgroundColor,
        body:SingleChildScrollView(
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
          
                    keyboardType: TextInputType.emailAddress,
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
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
                              value: _terms,
                              onChanged: (bool? checked) {
                                setState(() {
                                  _terms = checked ?? false;
                                });
                              },
                            ),
                            Text('I agree to ', style: TextStyle(fontSize: 14)),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Terms & conditions',
                                style: TextStyle(color: AppTheme.buttonColors),
                              ),
                            ),
                            Text(' and ', style: TextStyle(fontSize: 14)),
                            Text(
                              'Privacy Policy.',
                              style: TextStyle(color: AppTheme.buttonColors),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height(context)*.28),
                  GestureDetector(
                    onTap: () async {
                      try {
                        final user = await authController.signUp(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
          
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registered Successfully'),
                            ),
          
                          );
          
                          emailController.clear();
                          passwordController.clear();
                        }
          
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message ?? 'Sign up failed')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Unexpected error: $e')),
                        );
                      }
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CoinScreenList()));
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
