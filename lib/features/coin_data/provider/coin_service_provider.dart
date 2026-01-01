import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../services/coin_api_service.dart';
import '../model/coin_model.dart';
//Provides the API service
final coinApiServiceProvider = Provider<CoinApiService>((ref) {
  return CoinApiService();
});

// StateNotifier for coin list
class CoinListNotifier extends StateNotifier<AsyncValue<List<Coin>>> {
  CoinListNotifier(this.coinApiService) : super(const AsyncValue.loading()) {
    fetchCoins();
  }

  final CoinApiService coinApiService;

  Future<void> fetchCoins() async {
    state = const AsyncValue.loading();
    try {
      final coins = await coinApiService.fetchCoins();
      state = AsyncValue.data(coins);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

//provider for to display the list of coins from the API
final coinListProvider = StateNotifierProvider<CoinListNotifier, AsyncValue<List<Coin>>>((ref) {
  final coinApiService = ref.watch(coinApiServiceProvider);
  return CoinListNotifier(coinApiService);
});

//This state provider checks the texts in the textfield(initially an empty string)
final searchQueryProvider = StateProvider<String>((ref) => "");


/// FILTERED list provider (filters list as you search)
final filteredCoinListProvider = Provider<List<Coin>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final asyncCoins = ref.watch(coinListProvider);

  return asyncCoins.when(
    data: (coins) {
      if (query.isEmpty) {
        return coins; // show all coins by default
      }
      return coins.where((coin) {
        return coin.name.toLowerCase().contains(query);//return coins containing the Strings inputed in the previous empty state provider
      }).toList();
    },
    loading: () => [],
    error: (err, Stacktrace) => [],
  );
});
