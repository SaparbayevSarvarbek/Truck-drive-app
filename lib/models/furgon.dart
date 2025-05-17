class Fourgon {
  final String name;
  final String number;

  Fourgon({required this.name, required this.number});

  factory Fourgon.fromJson(Map<String, dynamic> json) {
    return Fourgon(
      name: json['name'] ?? 'Фургон номи йўқ',
      number: json['number'] ?? 'Фургон рақами йўқ',
    );
  }
}
