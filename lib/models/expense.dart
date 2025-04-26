class Expense {
  final int id;
  final String name;
  final int price;
  final String description;
  final int driver;
  final int raysHistory;

  Expense({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.driver,
    required this.raysHistory,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id']??0,
      name: json['name']??'',
      price: json['price']??0,
      description: json['description']??'',
      driver: json['driver']??0,
      raysHistory: json['rays_history']??0,
    );
  }
}