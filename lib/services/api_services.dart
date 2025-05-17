import 'dart:io';

import 'package:dio/dio.dart';
import 'package:truck_driver/models/debt_model.dart';
import 'package:truck_driver/models/expenses_data_model.dart';

class ApiService {
  Dio dio = Dio();

  Future<Map<String, dynamic>?> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      Response response = await dio.post('https://pyco.uz/auth/login/',
          data: formData,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"}));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {'error': 'Bad request ${response.statusCode}'};
      }
    } on SocketException {
      return {'error': 'Интернет билан муаммо бор'};
    } catch (e) {
      print('Login serviceda xatolik $e');
      return {'error': 'Бундай фойдаланувчи йўқ'};
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

  Future<String> uploadExpenses(ExpensesDataModel data, File image) async {
    try {
      FormData formData = FormData.fromMap({
        "price": data.price,
        "description": data.description,
        "driver": data.user,
        "chiqimlar": data.expense,
        "photo": await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      });

      Response response = await dio.post(
        'https://pyco.uz/chiqimlik/',
        data: formData,
      );

      if (response.statusCode == 200) {
        print("✅ Chiqim muvaffaqiyatli yuklandi!");
        return response.statusCode.toString();
      } else {
        print("❌ Server xatosi uploadExpenses: ${response.statusCode}");
        print("🔹 API javobi: ${response.data}");
        return response.statusCode.toString();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("🚨 API Xatolik uploadExpenses: ${e.response!.statusCode}");
        print("🔹 Serverdan javob: ${e.response!.data}");
      } else {
        print("❌ Xatolik uploadExpenses: ${e.message}");
      }
      return e.message.toString();
    }
  }

  Future<String> addComplaint(
      String role,String description, int driver) async {
    String url;
    if (role == 'asosiy') {
      url = 'https://pyco.uz/ariza/';
    } else if (role == 'qoshimcha') {
      url = 'https://pyco.uz/referens/';
    } else {
      throw Exception('Noto‘g‘ri rol tanlandi');
    }
    try {
      FormData formData = FormData.fromMap({
        "description": description,
        "driver": driver,
      });
      Response response = await dio.post(
        url,
        data: formData,
      );
      print("Add Complaint service");
      if (response.statusCode == 200) {
        print("✅ Chiqim muvaffaqiyatli yuklandi!");
        return response.statusCode.toString();
      } else {
        print("❌ Server xatosi addComplaint: ${response.statusCode}");
        print("🔹 API javobi: ${response.data}");
        return response.statusCode.toString();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("🚨 API Xatolik addComplaint: ${e.response!.statusCode}");
        print("🔹 Serverdan javob: ${e.response!.data}");
        return e.response.toString();
      } else {
        print("❌ Xatolik addComplaint: ${e.message}");
        return e.message.toString();
      }
    }
  }

  Future<Map<String, dynamic>> getHistory(int userId) async {
    try {
      final response = await dio.get('https://pyco.uz/customusers/$userId/driver-history/');
      return response.data;
    } catch (e) {
      throw Exception('Failed to load history: $e');
    }
  }

  Future<List<HistoryDebtModel>> getDebt(int userId) async {
    try {
      final response = await dio.get("https://pyco.uz/casa/via-driver-summary/?driver_id=$userId");

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((item) => HistoryDebtModel.fromJson(item)).toList();
      } else {
        throw Exception("Xatolik: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio hatolik: ${e.message}");
    } catch (e) {
      throw Exception("Noma’lum xatolik: $e");
    }
  }
}
