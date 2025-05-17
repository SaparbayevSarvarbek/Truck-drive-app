import 'product.dart';

class Client {
  final int id;
  final String firstName;
  final String lastName;
  final String number;
  final List<Product> products;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.products,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? 'Исм йўқ',
      lastName: json['last_name'] ?? 'Фамилия йўқ',
      number: json['number'] ?? '',
      products: (json['products'] as List?)?.map((e) => Product.fromJson(e)).toList() ?? [],
    );
  }
}