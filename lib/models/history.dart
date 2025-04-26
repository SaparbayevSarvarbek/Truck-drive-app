import 'package:truck_driver/models/product.dart';

import 'car.dart';
import 'client.dart';
import 'country.dart';
import 'driver.dart';
import 'expense.dart';
import 'furgon.dart';

class History {
  final int id;
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
  final List<Expense> expenses;

  History({
    required this.id,
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
    return History(
      id: json['id']??0,
      country: Country.fromJson(json['country']),
      driver: Driver.fromJson(json['driver']),
      car: Car.fromJson(json['car']),
      fourgon: Fourgon.fromJson(json['fourgon']),
      client: (json['client'] as List).map((e) => Client.fromJson(e)).toList(),
      price: json['price']??'Narxi yo\'q',
      drPrice: json['dr_price']??0,
      dpPrice: json['dp_price']??0,
      kilometer: json['kilometer']??0,
      dpInformation: json['dp_information']??'',
      createdAt: json['created_at']??'',
      count: json['count']??0,
      products: (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      expenses: (json['expenses'] as List).map((e) => Expense.fromJson(e)).toList(),
    );
  }
}
