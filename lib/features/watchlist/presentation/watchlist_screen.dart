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
    final favoriteService = ref.read(favoriteServiceProvider);


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Watchlist"),
        actions: [
         
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.grey.shade900,
                    title: const Text('Confirm Clear'),
                    content: const Text('Are you sure you want to clear all items from your watchlist?'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          
                          InkWell(
                            enableFeedback: true,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)
                          
                              ),child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text('Cancel',style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),),
                              )),
                          ),
                           InkWell(
                        enableFeedback: true,
                        onTap: () async {
                          Navigator.of(context).pop();
                          await favoriteService.clearAllFavorites(userId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All items cleared from watchlist')),
                          );
                        },
                        child: Container(decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12)
                        ),child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Clear',style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        )),
                      ),
                        ],
                      ),
                     
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
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