import 'package:truck_driver/models/product.dart';

import 'car.dart';
import 'client.dart';
import 'country.dart';
import 'driver.dart';
import 'furgon.dart';

class History {
  final Country country;
  final Driver driver;
  final Car car;
  final Fourgon fourgon;
  final List<Client> clients;
  final List<Product> products;
  final double price;
  final double drPrice;
  final double dpPrice;
  final String dpInformation;
  final String createdAt;

  History({
    required this.country,
    required this.driver,
    required this.car,
    required this.fourgon,
    required this.clients,
    required this.products,
    required this.price,
    required this.drPrice,
    required this.dpPrice,
    required this.dpInformation,
    required this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    var listClients = json['client'] as List;
    var listProducts = json['products'] as List;

    return History(
      country: Country.fromJson(json['country']),
      driver: Driver.fromJson(json['driver']),
      car: Car.fromJson(json['car']),
      fourgon: Fourgon.fromJson(json['fourgon']),
      clients: listClients.map((client) => Client.fromJson(client)).toList(),
      products: listProducts.map((product) => Product.fromJson(product)).toList(),
      price: json['price'].toDouble(),
      drPrice: json['dr_price'].toDouble(),
      dpPrice: json['dp_price'].toDouble(),
      dpInformation: json['dp_information'],
      createdAt: json['created_at'],
    );
  }
}
