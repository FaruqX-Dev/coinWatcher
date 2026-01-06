import 'dart:math';

import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/features/coin_data/model/coin_model.dart';
import 'package:coin_watcher/features/notifications/services/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/auth_provider.dart';
import '../../watchlist/provider/firestore_providers.dart';

class CoinDetailsContainer extends ConsumerWidget {
  final Coin coin;

  const CoinDetailsContainer({super.key, required this.coin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkModeOn = ref.watch(isThemeDarkModeProvider);
    final user = ref.watch(authenticatedUserProvider);
    final userId = user?.uid;
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
                    style: TextStyle(
                        color: isDarkModeOn ? Colors.white : Colors.white,
                        fontSize: 18),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      //anonymous or null users cannot add to favourites(Must sign in)
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please log in to add coins to your watchlist',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                        return;
                      }

                      final favoriteService = ref.read(favoriteServiceProvider);
                      final notificationService = LocalNotificationService();

                      await favoriteService.toggleFavorite(userId, coin);

                      // If removing from watchlist cancel notifications for coin update
                      if (isFavorite) {
                        await notificationService
                            .cancelNotification(coin.id.hashCode);
                        await notificationService
                            .cancelNotification(coin.id.hashCode + 1);
                        return;
                      }

                      // If adding to watchlist schedule morning and evening notifications
                      await notificationService.requestPermissionIfNeeded();

                      final change = coin.priceChangePercentage24h;
                      final direction = change >= 0 ? 'increased' : 'decreased';
                      final now = DateTime.now();
                      final random = Random();

                      // Morning notification between 8 AM – 11:59 AM
                      DateTime morningTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        8 + random.nextInt(4),
                        random.nextInt(60),
                      );
                      if (!morningTime.isAfter(now)) {
                        morningTime = morningTime.add(const Duration(days: 1));
                      }

                      await notificationService.scheduleNotification(
                        id: coin.id.hashCode,
                        title: '${coin.name} Update',
                        body:
                            '${coin.name} has $direction by ${change.abs().toStringAsFixed(2)}% '
                            'in the last 24 hours. Current price: \$${coin.currentPrice}',
                        scheduledDate: morningTime,
                        matchDateTimeComponents: DateTimeComponents.time,
                      );

                      //Evening notification between 6 PM – 9:59 PM
                      DateTime eveningTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        18 + random.nextInt(4),
                        random.nextInt(60),
                      );
                      if (!eveningTime.isAfter(now)) {
                        eveningTime = eveningTime.add(const Duration(days: 1));
                      }

                      await notificationService.scheduleNotification(
                        id: coin.id.hashCode + 1,
                        title: '${coin.name} Update',
                        body:
                            '${coin.name} has $direction by ${change.abs().toStringAsFixed(2)}% '
                            'in the last 24 hours. Current price: \$${coin.currentPrice}',
                        scheduledDate: eveningTime,
                        matchDateTimeComponents: DateTimeComponents.time,
                      );
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            isFavorite ? Colors.amber.shade800 : Colors.green,
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
