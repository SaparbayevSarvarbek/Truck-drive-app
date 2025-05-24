import 'expense.dart';

import 'car.dart';
import 'client.dart';
import 'country.dart';
import 'driver.dart';
import 'furgon.dart';
import 'product.dart';

class History {
  final int id;
  final int raysId;
  final Country country;
  final Driver driver;
  final Car car;
  final Fourgon fourgon;
  final List<Client> client;
  final int price;
  final int drPrice;
  final int dpPrice;
  final int kilometer;
  final String dpInformation;
  final String createdAt;
  final int count;
  final List<Product> products;
  final Expense expenses;

  History({
    required this.id,
    required this.raysId,
    required this.country,
    required this.driver,
    required this.car,
    required this.fourgon,
    required this.client,
    required this.price,
    required this.drPrice,
    required this.dpPrice,
    required this.kilometer,
    required this.dpInformation,
    required this.createdAt,
    required this.count,
    required this.products,
    required this.expenses,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    List<Client> clients =
        (json['client'] as List?)?.map((e) => Client.fromJson(e)).toList() ??
            [];

    List<Product> allProducts = [];
    for (var c in clients) {
      allProducts.addAll(c.products);
    }

    return History(
      id: json['id'] ?? 0,
      raysId: json['rays_id'] ?? 0,
      country: Country.fromJson(json['country']),
      driver: Driver.fromJson(json['driver']),
      car: Car.fromJson(json['car']),
      fourgon: Fourgon.fromJson(json['fourgon']),
      client: clients,
      price: json['price'] ?? 0,
      drPrice: json['dr_price'] ?? 0,
      dpPrice: json['dp_price'] ?? 0,
      kilometer: json['kilometer'] ?? 0,
      dpInformation: json['dp_information'] ?? '',
      createdAt: json['created_at'] ?? '',
      count: json['count'] ?? 0,
      products: allProducts,
      expenses: Expense.fromJson(json['expenses'] ?? {}),
    );
  }
}
