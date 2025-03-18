import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_driver/models/user_database.dart';
import 'package:truck_driver/models/user_model.dart';

import '../services/api_services.dart';
import '../view/home_page.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? errorMessage;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginUser(String username, String password, BuildContext context) async {
    setLoading(true);
    final response = await _apiService.login(username, password);
    setLoading(false);

    if (response != null) {
      if (response.containsKey('refresh')) {

        String token = response['access'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        UserModel user = UserModel.fromJson(response['user']);
        await UserDatabase.saveUser(user.toJson());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kirish muvaffaqiyatli!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      else {
        errorMessage = response['error'] ?? 'Bunday foydalanuvchi yo\'q';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarmoq xatoligi yuz berdi')),
      );
    }
  }
  Future logOut(String refreshToken)async{
    ApiService().logOut(refreshToken);
    notifyListeners();
  }
}