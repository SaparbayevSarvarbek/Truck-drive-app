import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio();

  Future<Map<String, dynamic>?> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      Response response = await dio.post(
          'https://oyinlar.pythonanywhere.com/api/token/',
          data: formData,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"}));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {'error': 'Bad request ${response.statusCode}'};
      }
    } on SocketException {
      return {'error': 'Internet bilan muammo bor'};
    } catch (e) {
      print('Login serviceda xatolik $e');
      return {'error': 'Bunday foydalanuvchi yo\'q'};
    }
  }
}
