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

  Future<void> fetchHistory(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getHistory(userId);
      List jsonResponse = response['history'];
      _historyList = jsonResponse.map((e) => History.fromJson(e)).toList();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load history: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
