import 'dart:convert';

import 'package:coin_watcher/features/coin_data/model/coin_model.dart';
import 'package:http/http.dart' as http;

class CoinApiService {
  Future<List<Coin>> fetchCoins() async {
    final url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd';
    final response = await http.get(Uri.parse(url));

    final List decoded = jsonDecode(response.body);
    return decoded.map((e) => Coin.fromJson(e)).toList();
  }
}


