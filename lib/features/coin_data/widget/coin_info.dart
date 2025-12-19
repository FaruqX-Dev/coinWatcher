import 'package:coin_watcher/features/coin_data/model/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/auth_provider.dart';
import '../../watchlist/provider/firestore_providers.dart';

class CoinDetailsContainer extends ConsumerWidget {
  final Coin coin;

  const CoinDetailsContainer({super.key, required this.coin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)?.uid;
    final favoriteIds =
        ref.watch(favoriteIdsProvider(userId ?? "")).value ?? [];
    final isFavorite = favoriteIds.contains(coin.id);
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(coin.image)),
                  SizedBox(width: 10),
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Text(
                    "Symbol: ${coin.symbol.toUpperCase()}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (userId != null) {
                        await ref
                            .read(favoriteServiceProvider)
                            .toggleFavorite(userId, coin);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please log in to save favorites'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isFavorite ? Colors.amber.shade800 : Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.star_border, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              isFavorite ? 'In Watchlist' : 'Add to Watchlist',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                "Current Price: \$${coin.currentPrice}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),

              const SizedBox(height: 10),

              Text(
                "MarketCap Rank: ${coin.marketCapRank}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 12),

              Text(
                "MarketCap: \$${coin.marketCap}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 12),

              Text(
                "Total Volume: \$${coin.totalVolume}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
