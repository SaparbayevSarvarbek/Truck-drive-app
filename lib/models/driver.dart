class Driver {
  final String fullname;
  final String phoneNumber;

  Driver({required this.fullname, required this.phoneNumber});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullname: json['fullname'],
      phoneNumber: json['phone_number'],
    );
  }
}
