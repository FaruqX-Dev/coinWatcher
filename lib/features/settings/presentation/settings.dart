import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/core/widget/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkModeOn=ref.watch(isThemeDarkModeProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text(isDarkModeOn?'Dark Mode':'Light Mode',style: TextStyle(
                      fontSize: 18,
                    ),),
                    SizedBox(width: 5,),
                    Icon(isDarkModeOn?Icons.dark_mode:Icons.light_mode)
                  ],
                ),
                trailing: Switch(
                  value: isDarkModeOn,
                  activeThumbColor: AppTheme.buttonColors,
                  onChanged: (value) {
                    themeNotifier.toggleTheme();
                  },
                ),
              ),
              ListTile(
                title: Text('Share'),
                trailing: Icon(Icons.arrow_forward_ios),
                
              ),
              ListTile(
                title: Text('Rate Us'),
                trailing: Icon(Icons.arrow_forward_ios),
        
                
              ),

            ],
          ),
        ),
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
            const Text("About CoinWatcher", style: TextStyle(color: Colors.white)),
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
              "A powerful crypto tracking app built with Flutter and Firebase. "
                  "Monitor 24h price changes and manage your portfolio with ease.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Developed with ❤️ using Riverpod",
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
