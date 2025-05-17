class Driver {
  final int id;
  final String fullname;
  final String phoneNumber;

  Driver({required this.id, required this.fullname, required this.phoneNumber});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? 'Ҳайдовчи исми йўқ',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}

