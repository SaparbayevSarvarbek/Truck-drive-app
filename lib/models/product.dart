class Product {
  final int id;
  final String fromLocationName;
  final String toLocationName;
  final String clientName;
  final String currencyName;
  final String name;
  final dynamic price;
  final String priceInUsd;
  final dynamic customRateToUzs;
  final int count;
  final String description;
  final String photo;
  final bool isBusy;
  final bool isDelivered;

  Product({
    required this.id,
    required this.fromLocationName,
    required this.toLocationName,
    required this.clientName,
    required this.currencyName,
    required this.name,
    required this.price,
    required this.priceInUsd,
    required this.customRateToUzs,
    required this.count,
    required this.description,
    required this.photo,
    required this.isBusy,
    required this.isDelivered,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      fromLocationName: json['from_location_name'] ?? '',
      toLocationName: json['to_location_name'] ?? '',
      clientName: json['client_name'] ?? '',
      currencyName: json['currency_name'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      priceInUsd: json['price_in_usd'] ?? '',
      customRateToUzs: json['custom_rate_to_uzs'],
      count: json['count'] ?? 0,
      description: json['description'] ?? '',
      photo: json['photo'] ?? '',
      isBusy: json['is_busy'] ?? false,
      isDelivered: json['is_delivered'] ?? false,
    );
  }
}