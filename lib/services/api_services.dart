import 'dart:io';

import 'package:dio/dio.dart';
import 'package:truck_driver/models/expenses_data_model.dart';

class ApiService {
  Dio dio = Dio();

  Future<Map<String, dynamic>?> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      Response response = await dio.post('https://pyco.uz/login/',
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

  void logOut(String refreshToken) async {
    FormData formData = FormData.fromMap({
      'refresh': refreshToken,
    });
    try {
      await dio.post('https://pyco.uz/login/',
          data: formData,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"}));
    } catch (e) {
      print('Logout serviceda xatolik: $e');
    }
  }

  void uploadExpenses(ExpensesDataModel data, File image) async {
    try {
      FormData formData = FormData.fromMap({
        "price": data.price, // ✅ stringga o'tkazildi
        "description": data.description,
        "driver": 1, // 🔥 PK ID qilib yuborish
        "chiqimlar": 2, // 🔥 PK ID qilib yuborish
        "photo": await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      });

      Response response = await dio.post(
        'https://pyco.uz/chiqimlik/',
        data: formData,
      );

      if (response.statusCode == 200) {
        print("✅ Chiqim muvaffaqiyatli yuklandi!");
      } else {
        print("❌ Server xatosi: ${response.statusCode}");
        print("🔹 API javobi: ${response.data}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("🚨 API Xatolik: ${e.response!.statusCode}");
        print("🔹 Serverdan javob: ${e.response!.data}");
      } else {
        print("❌ Xatolik: ${e.message}");
      }
    }
  }

}
