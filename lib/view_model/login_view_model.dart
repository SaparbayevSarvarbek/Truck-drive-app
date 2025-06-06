
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_driver/models/user_database.dart';
import 'package:truck_driver/models/user_model.dart';
import 'package:truck_driver/theme/my_dialog.dart';

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
    try {
      final response = await _apiService.login(username, password);
      if (response != null) {
        if (response.containsKey('refresh')) {
          String token = response['access'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          await prefs.setBool('isLoggedIn', true);
          UserModel user = UserModel.fromJson(response['user']);
          await UserDatabase.saveUser(user.toJson());

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          MyDialog.info('Кириш муваффақиятли!');
        } else {
          errorMessage = response['error'] ?? 'Бундай фойдаланувчи йўқ';
          MyDialog.error("$errorMessage");
        }
      } else {
        MyDialog.error('Тармоқ хатолиги юз берди');
      }
    } catch (e) {
      MyDialog.error('Хатолик: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future logOut(String refreshToken)async{
    ApiService().logOut(refreshToken);
    notifyListeners();
  }
}