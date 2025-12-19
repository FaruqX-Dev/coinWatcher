# TODO: Implement Coin Price Change Monitoring

- [ ] Create StateNotifierProvider in coin_service_provider.dart for managing list of CoinPriceState with periodic price updates
- [ ] Update coin_screen_list.dart to use the new provider instead of coinListProvider
- [ ] Modify coin_tile.dart to accept CoinPriceState and color price text based on trend (green for increase, red for decrease)
- [ ] Test the app for price updates and color changes
