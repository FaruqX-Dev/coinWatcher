import 'package:coin_watcher/features/coin_data/model/coin_model.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  final Coin coin;

  const CoinTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final isNegative = coin.priceChangePercentage24h < 0;

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(coin.image)),
      title: Text(
        coin.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(coin.symbol),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${coin.currentPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
            style: TextStyle(
              color: isNegative ? Colors.red : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
