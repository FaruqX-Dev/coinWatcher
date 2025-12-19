class Coin {
  final String id;
  final String name;
  final String image;
  final String symbol;
  final double currentPrice;
  final double marketCap;
  final double marketCapRank;
  final double priceChangePercentage24h;
  final double totalVolume;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
    required this.totalVolume,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      image: json['image'],
      currentPrice: json['current_price']?.toDouble() ?? 0.0,
      totalVolume: json['total_volume']?.toDouble() ?? 0.0,
      marketCap: json['market_cap']?.toDouble() ?? 0.0,
      marketCapRank: json['market_cap_rank']?.toDouble() ?? 0.0,
      priceChangePercentage24h:
          json['price_change_percentage_24h']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'total_volume':totalVolume,
      'market_cap_rank': marketCapRank,
      'price_change_percentage_24h': priceChangePercentage24h,
    };
  }
}
