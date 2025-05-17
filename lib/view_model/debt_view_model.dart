import 'package:flutter/material.dart';

import '../models/debt_model.dart';
import '../services/api_services.dart';

class DebtViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<HistoryDebtModel> _histories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<HistoryDebtModel> get histories => _histories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchHistory(int userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _histories = await _apiService.getDebt(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
