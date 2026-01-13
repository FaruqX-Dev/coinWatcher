import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/features/coin_data/widget/coin_info.dart';
import 'package:coin_watcher/features/coin_data/widget/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../provider/coin_service_provider.dart';
import '../../../core/widget/mydrawer.dart';

/// toggles search bar visibility
final isSearchingProvider = StateProvider<bool>((ref) => false);

class CoinScreenList extends ConsumerStatefulWidget {
  const CoinScreenList({super.key});

  @override
  ConsumerState<CoinScreenList> createState() => _CoinScreenListState();
}

class _CoinScreenListState extends ConsumerState<CoinScreenList> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtTop = true;

  Future<void> _refreshCoinList() async {
    await ref.read(coinListProvider.notifier).fetchCoins();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final atTop = _scrollController.offset <= 0;
    if (atTop != _isAtTop) {
      setState(() => _isAtTop = atTop);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn=ref.watch(isThemeDarkModeProvider);
    final isSearching = ref.watch(isSearchingProvider);
    final coinsAsync = ref.watch(coinListProvider);
    final filteredCoins = ref.watch(filteredCoinListProvider);
    ref.watch(isThemeDarkModeProvider);
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
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              final notifier = ref.read(isSearchingProvider.notifier);
              notifier.state = !notifier.state;

              if (!notifier.state) {
                ref.read(searchQueryProvider.notifier).state = "";
              }
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: coinsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wifi_off,
                  size: 48,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Network error',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => ref.read(coinListProvider.notifier).fetchCoins(),
        
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade800),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Icon(Icons.refresh,color: isDarkModeOn?Colors.white:Colors.white,),
                          Text(
                            'Refresh',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        data: (_) {
          if (filteredCoins.isEmpty) {
            return const Center(
              child: Text(
                'No coins found',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return Column(
            children: [
              if (_isAtTop)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pull down to refresh',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_downward, size: 12),
                    ],
                  ),
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshCoinList,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredCoins.length,
                    itemBuilder: (context, index) {
                      final coin = filteredCoins[index];
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => CoinDetailsContainer(coin: coin),
                          );
                        },
                        child: CoinTile(coin: coin),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
