class Product {
  final String name;
  final double price;
  final int count;
  final String fromLocation;
  final String toLocation;

  Product({
    required this.name,
    required this.price,
    required this.count,
    required this.fromLocation,
    required this.toLocation,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price: json['price'].toDouble(),
      count: json['count'] ?? '',
      fromLocation: json['from_location'] ?? 'Номаълум',
      toLocation: json['to_location'] ?? 'Номаълум',
    );
  }
}
