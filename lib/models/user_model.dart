class UserModel{
  int id;
  String username;
  String fullName;
  String phoneNumber;
  String status;
  final String? profileImage;

  UserModel(
      {required this.id, required this.username,required this.fullName, required this.phoneNumber, required this.status,required this.profileImage});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      fullName: json['fullname'],
      phoneNumber: json['phone_number'],
      status: json['status'],
      profileImage: json['profileImage'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullname': fullName,
      'phone_number': phoneNumber,
      'status': status,
      'profileImage': profileImage,
    };
  }
}