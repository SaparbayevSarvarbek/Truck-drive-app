class Driver {
  final String fullname;
  final String phoneNumber;

  Driver({required this.fullname, required this.phoneNumber});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullname: json['fullname']??'Ҳайдовчи исми йўқ',
      phoneNumber: json['phone_number']??0,
    );
  }
}
