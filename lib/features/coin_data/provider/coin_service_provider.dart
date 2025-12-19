import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../services/coin_api_service.dart';
import '../model/coin_model.dart';
//Provides the API service
final coinApiServiceProvider = Provider<CoinApiService>((ref) {
  return CoinApiService();
});


//provider for to display the list of coins from the API
final coinListProvider = FutureProvider<List<Coin>>((ref) async {
  final coinApiService = ref.watch(coinApiServiceProvider);
  return coinApiService.fetchCoins();//the fetch coins function to get the coins
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
