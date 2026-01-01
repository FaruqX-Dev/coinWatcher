import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/utils/screensize.dart';
import 'package:coin_watcher/features/settings/presentation/settings.dart';
import 'package:coin_watcher/features/watchlist/presentation/watchlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/provider/auth_provider.dart';
import '../../features/auth/widget/confirm_signout.dart';
import '../../features/coin_data/presentation/coin_screen_list.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkModeOn = ref.watch(isThemeDarkModeProvider);
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Image.asset('assets/images/panda.png', scale: 7)],
                ),
                SizedBox(height: 15),
                Text(
                  'User: ${ref.watch(currentUserProvider)?.email}',
                  style: TextStyle(
                      fontSize: 15,
                      color: isDarkModeOn ? Colors.white : Colors.black),
                ),
                Row(
                  spacing: 5,
                  children: [
                    Text(
                        'e-mail Verified: ${ref.watch(currentUserProvider)?.emailVerified}'),
                    if (ref.watch(currentUserProvider)?.emailVerified == true)
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    else
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: .2,
                      width: ScreenSize.width(context) * .7,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenSize.height(context) * .35,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      enableFeedback: true,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoinScreenList(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.dashboard),
                          SizedBox(width: 30),
                          Text('DashBoard', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    enableFeedback: true,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritesScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.star),
                          SizedBox(width: 30),
                          Text('Watchlist', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    enableFeedback: true,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(width: 30),
                          Text('Settings', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    enableFeedback: true,
                    onTap: () {
                      showCustomAboutDialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.library_books),
                          SizedBox(width: 30),
                          Text('About', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: .2,
                width: ScreenSize.width(context) * .7,
                color: Colors.grey.shade700,
              ),
            ],
          ),
          InkWell(
            enableFeedback: true,
            onTap: () {
              showHelpSupportDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.help),
                        SizedBox(width: 30),
                        Text('Help & Support', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  InkWell(
                    enableFeedback: true,
                    onTap: () {
                      showPrivacyPolicy(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.privacy_tip),
                          SizedBox(width: 30),
                          Text('Privacy Policy',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            enableFeedback: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmSignout(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: ScreenSize.width(context) * .6,
                decoration: BoxDecoration(
                  color: isDarkModeOn
                      ? AppTheme.appBackgroundColor
                      : AppTheme.buttonColors,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 5),
                    Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            'v1.0',
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

void showCustomAboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.green),
            const SizedBox(width: 10),
            const Text("About CoinWatcher",
                style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 15),
            const Text(
              "A powerful crypto tracking app built with Flutter. "
              "Monitor 24h price changes and manage your portfolio with ease.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Developed with ❤️ using Flutter",
                style: TextStyle(color: Colors.green.shade400, fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CLOSE", style: TextStyle(color: Colors.green)),
          ),
        ],
      );
    },
  );
}

void showPrivacyPolicy(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          // Setting a width ensures it looks good on tablets and phones
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _policySection("1. Data Collection",
                    "CoinWatcher collects your email address and UID via Firebase Authentication to manage your account and watchlist."),
                _policySection("2. Watchlist Data",
                    "Your favorite coins are stored securely in Firestore and are only accessible by you via your unique user ID."),
                _policySection("3. Price Alerts",
                    "If enabled, we use Firebase Cloud Messaging to send you price updates. You can opt-out at any time in your device settings."),
                _policySection("4. Third-Party Services",
                    "We use CoinGecko API for market data and Firebase for backend services. These services may collect device identifiers as per their own policies."),
                _policySection("5. Data Deletion",
                    "You may request account deletion at any time, which will remove your email and saved favorites from our database."),
                const SizedBox(height: 10),
                const Text(
                  "Last Updated: December 2025",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("I UNDERSTAND",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}

// Helper widget to keep the code clean
Widget _policySection(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style:
              const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
        ),
      ],
    ),
  );
}

void showHelpSupportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.support_agent, color: Colors.green),
            SizedBox(width: 10),
            Text(
              "Help & Support",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Solo Developer Project",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "CoinWatcher is a passion project built entirely by a solo developer. "
              "I am constantly working to improve the experience and add new features.",
              style:
                  TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 20),
            const Text(
              "Collaboration & Support",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "I am open to support, feedback, and collaboration opportunities! "
              "If you'd like to contribute, report a bug, or just say hello, feel free to reach out:",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.green, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "faruqbello0303@gmail.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "CLOSE",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
