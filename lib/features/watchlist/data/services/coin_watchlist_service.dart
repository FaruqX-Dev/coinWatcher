import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_watcher/features/coin_data/model/coin_model.dart';

class FavoriteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of favorite coin IDs for a specific user
  Stream<List<String>> getFavoriteIds(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  // Toggle Favorite
  Future<void> toggleFavorite(String userId, Coin coin) async {
    final docRef = _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(coin.id);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set(coin.toJson()); // Saving the whole model makes the Fav screen faster
    }
  }

  // Stream of actual Coin objects for the Favorites Screen
  Stream<List<Coin>> getFavoriteCoins(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Coin.fromJson(doc.data())).toList());
  }
}