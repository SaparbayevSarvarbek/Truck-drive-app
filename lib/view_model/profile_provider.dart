import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user_database.dart';

class ProfileProvider extends ChangeNotifier {
  File? _image;

  File? get image => _image;

  ProfileProvider() {
    loadUserImage();
  }

  Future<void> loadUserImage() async {
    Map<String, dynamic>? userMap = await UserDatabase.getUser();
    if (userMap != null && userMap["profileImage"] != null) {
      _image = File(userMap["profileImage"]);
      notifyListeners();
    }
  }

  Future<void> pickImage(File newImage) async {
    _image = newImage;
    await UserDatabase.updateProfileImage(newImage.path);
    notifyListeners();
  }
}
