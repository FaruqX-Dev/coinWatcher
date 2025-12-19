import 'package:coin_watcher/core/widget/mydrawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/auth_provider.dart';
import '../../coin_data/widget/coin_info.dart';
import '../../coin_data/widget/coin_tile.dart';
import '../provider/firestore_providers.dart';
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)?.uid ?? "";
    final favoriteCoinsAsync = ref.watch(favoriteCoinsProvider(userId));

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("My Watchlist"),),
      drawer: MyDrawer(),
      body: favoriteCoinsAsync.when(
        data: (coins) => coins.isEmpty
            ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/sad_panda2.png',
                  scale: .1,
                ),
                 Text("It's empty in here!",style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),),
                 Text(textAlign: TextAlign.center,"Don't make the panda sad. Start tracking\nyour favourite crypto assets to fill up this\nspace."),
              ],
            ))
            : ListView.builder(
          itemCount: coins.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (_)=>CoinDetailsContainer(coin: coins[index],));
            },
              child: CoinTile(coin: coins[index])),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}