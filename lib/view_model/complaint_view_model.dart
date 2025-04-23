import 'package:flutter/widgets.dart';

import '../services/api_services.dart';

class ComplaintViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<String> addComplaint(
      String role,String description, int driver) async {
    String data =
        await ApiService().addComplaint(role,description, driver);
    notifyListeners();
    return data;
  }

  void changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
