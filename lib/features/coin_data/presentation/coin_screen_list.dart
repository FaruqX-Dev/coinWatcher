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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _isAtTop = _scrollController.offset <= 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider);
    ref.watch(isThemeDarkModeProvider);
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
          : Column(
              children: [
                if (_isAtTop)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pull down to refresh',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Icon(Icons.arrow_downward,size: 12.0,)
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshCoinList,
                    child: ListView.builder(
                      controller: _scrollController,
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
                  ),
                ),
              ],
            ),
    );
  }
}
