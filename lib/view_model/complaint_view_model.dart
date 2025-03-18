import 'package:flutter/widgets.dart';

import '../services/api_services.dart';

class ComplaintViewModel extends ChangeNotifier {
  bool isLoading = false;

  void addExpenses(
      String description, String categoryComplaint, int driver) async {
    ApiService().addComplaint(description,categoryComplaint,driver);
    notifyListeners();
  }

  void changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
