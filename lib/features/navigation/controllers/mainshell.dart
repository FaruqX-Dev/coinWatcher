import 'package:coin_watcher/core/widget/mydrawer.dart';
import 'package:coin_watcher/features/coin_data/presentation/coin_screen_list.dart';
import 'package:coin_watcher/features/navigation/providers/navigation_provider.dart';
import 'package:coin_watcher/features/settings/presentation/settings.dart';
import 'package:coin_watcher/features/watchlist/presentation/watchlist_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    // List of screens to display
    final List<Widget> screens = [
      const CoinScreenList(),
      const FavoritesScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      drawer: const MyDrawer(),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
    );
  }
}