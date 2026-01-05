import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/utils/screensize.dart';
import 'package:coin_watcher/features/auth/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.appBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: ScreenSize.width(context) * .15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/cwatch_logo.png', scale: 1.2),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        'CoinWatcher',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.none),
                    boxShadow: [
                      BoxShadow(color: AppTheme.buttonColors, blurRadius: 20),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/ring_image.png',
                    scale: 1.8,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Your Crypto Portfolio, Simplified.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Track prices,manage assets, and get real-time alerts for hundreds of cryptocurrecies.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: .25 * ScreenSize.width(context),
                    right: ScreenSize.width(context) * .25,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Image.asset(
                              'assets/images/icon_one.png',
                              scale: 1.8,
                            ),
                          ),
                          Text(
                            'Real-Time Tracking',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Image.asset(
                              'assets/images/icon_two.png',
                              scale: 1.8,
                            ),
                          ),
                          Text(
                            'Custom Alerts',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icon_three.png',
                            scale: 1.8,
                          ),
                          Text(
                            'Portfolio Management',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenSize.height(context) * .02,
                ),
                // InkWell(
                //   enableFeedback: true,
                //   onTap: () =>onGetStarted(),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       width: ScreenSize.width(context) * .9,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: AppTheme.buttonColors,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           'Get Started',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             fontSize: 18,
                //             color: AppTheme.constantTextColor,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  width:ScreenSize.width(context) * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: ElevatedButton(
                    
                    onPressed:()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: 
                    (context)=>AuthGate())),
                    style:ElevatedButton.styleFrom(
                      elevation: 2.0,
                      backgroundColor: AppTheme.buttonColors,
                      foregroundColor: Colors.black,
                     
                      alignment: Alignment.center,
                      
                    ) ,
                    child:Text('Get Started',style: TextStyle(
                           fontSize: 18,
                          color: AppTheme.constantTextColor,
                            fontWeight: FontWeight.bold,
                          ),) ,
                  ),
                )
               
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
