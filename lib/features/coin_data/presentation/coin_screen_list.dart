import 'package:coin_watcher/features/coin_data/widget/coin_info.dart';
import 'package:coin_watcher/features/coin_data/widget/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../provider/coin_service_provider.dart';
import '../../../core/widget/mydrawer.dart';

/// toggles search bar visibility
final isSearchingProvider = StateProvider<bool>((ref) => false);

class CoinScreenList extends ConsumerWidget {
  const CoinScreenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider);
    final filteredCoins = ref.watch(filteredCoinListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isSearching
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search coins...",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              )
            : const Text('CoinWatcher'),
        actions: [
          IconButton(
            icon: isSearching
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
            onPressed: () {
              final notifier = ref.read(isSearchingProvider.notifier);
              notifier.state = !notifier.state;

              // Reset search query when search is closed
              if (!notifier.state) {
                ref.read(searchQueryProvider.notifier).state = "";
              }
            },
          ),
        ],
      ),
      drawer: MyDrawer(),

      // Filtered list updates as you type
      body: filteredCoins.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.white,))
          : ListView.builder(
              itemCount: filteredCoins.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          CoinDetailsContainer(coin: filteredCoins[index]),
                    );
                  },
                  child: CoinTile(coin: filteredCoins[index]),
                );
              },
            ),
    );
  }

}
