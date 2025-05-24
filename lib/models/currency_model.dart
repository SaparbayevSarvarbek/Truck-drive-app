class CurrencyModel {
  final int id;
  final String currencyDisplay;
  final String currency;
  final String rateToUzs;
  final String updatedAt;

  CurrencyModel({
    required this.id,
    required this.currencyDisplay,
    required this.currency,
    required this.rateToUzs,
    required this.updatedAt,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      currencyDisplay: json['currency_display'],
      currency: json['currency'],
      rateToUzs: json['rate_to_uzs'],
      updatedAt: json['updated_at'],
    );
  }
}
