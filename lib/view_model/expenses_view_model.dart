import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truck_driver/models/expenses_data_model.dart';

import '../services/api_services.dart';

class ExpensesViewModel extends ChangeNotifier {
  bool isLoading=false;
  void addExpenses(ExpensesDataModel data,File image) async {
    ApiService().uploadExpenses(data,image);
    notifyListeners();
  }
  void changeLoadingState(){
    isLoading=!isLoading;
    notifyListeners();
  }
}
