import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truck_driver/models/expenses_data_model.dart';

import '../services/api_services.dart';

class ExpensesViewModel extends ChangeNotifier {
  bool isLoading=false;
  Future<String> addExpenses(ExpensesDataModel data,File image) async {
    notifyListeners();
    return await ApiService().uploadExpenses(data,image);
  }
  void changeLoadingState(){
    isLoading=!isLoading;
    notifyListeners();
  }
}
