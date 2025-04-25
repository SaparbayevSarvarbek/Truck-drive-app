import 'package:truck_driver/models/product.dart';

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
    var listProducts = json['products'] as List;

    return Client(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      number: json['number'],
      products: listProducts.map((product) => Product.fromJson(product)).toList(),
    );
  }
}
