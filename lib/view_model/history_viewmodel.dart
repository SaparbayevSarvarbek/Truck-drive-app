import 'package:flutter/foundation.dart';
import '../models/history.dart';
import '../services/api_services.dart';

class HistoryViewModel extends ChangeNotifier {
  List<History> _historyList = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<History> get historyList => _historyList;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  // Yangi metodlar
  Future<void> getHistoryWithoutApiCall(int userId) async {
    _isLoading = true;
    notifyListeners();

    // Shartni tekshirib so'rovni to'liq bajarish
    await Future.delayed(Duration(
        seconds: 2)); // Faqat simulyatsiya qilish uchun vaqtni qo'shish
    _historyList =
        []; // O'zingizga mos ravishda ma'lumot qo'yishingiz mumkin, hozirda bo'sh ro'yxat.
    _errorMessage = '';

    // Boshqa shartlarni tekshirib xatolikni qaytarish
    if (_historyList.isEmpty) {
      _errorMessage = 'No history available';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Avvalgi usul bo'lgani kabi, API so'rovi bajaradigan metod
  Future<void> fetchHistory(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getHistory(userId);
      List jsonResponse = response['history'];
      _historyList =
          jsonResponse.map((history) => History.fromJson(history)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load history: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
