import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../coin_data/model/coin_model.dart';
import '../data/services/coin_watchlist_service.dart';


final favoriteServiceProvider = Provider((ref) => FavoriteService());

// List of favorite IDs (used to change the star icon color)
final favoriteIdsProvider = StreamProvider.family<List<String>, String>((ref, userId) {
  return ref.watch(favoriteServiceProvider).getFavoriteIds(userId);
});

// List of full Coin objects (used for the Favorites Screen)
final favoriteCoinsProvider = StreamProvider.family<List<Coin>, String>((ref, userId) {
  return ref.watch(favoriteServiceProvider).getFavoriteCoins(userId);
});
