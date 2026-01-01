import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../coin_data/model/coin_model.dart';
import '../../coin_data/provider/coin_service_provider.dart';
import '../data/services/coin_watchlist_service.dart';


final favoriteServiceProvider = Provider((ref) => FavoriteService());

// List of favorite IDs (used to change the star icon color)
final favoriteIdsProvider = StreamProvider.family<List<String>, String>((ref, userId) {
  return ref.watch(favoriteServiceProvider).getFavoriteIds(userId);
});

// List of full Coin objects (used for the Favorites Screen) with live prices
final favoriteCoinsProvider = Provider.family<AsyncValue<List<Coin>>, String>((ref, userId) {
  final favoriteIdsAsync = ref.watch(favoriteIdsProvider(userId));
  final coinListAsync = ref.watch(coinListProvider);

  return favoriteIdsAsync.when(
    data: (ids) => coinListAsync.when(
      data: (coins) => AsyncValue.data(coins.where((coin) => ids.contains(coin.id)).toList()),
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
    ),
    loading: () => const AsyncValue.loading(),
    error: (e, s) => AsyncValue.error(e, s),
  );
});
