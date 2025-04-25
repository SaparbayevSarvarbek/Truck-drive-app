class Car {
  final String name;
  final String number;

  Car({required this.name, required this.number});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json['name'],
      number: json['number'],
    );
  }
}
