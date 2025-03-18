import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../models/user_database.dart';
import '../models/user_model.dart';
import '../view_model/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userData;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userMap = await UserDatabase.getUser();
    if (userMap != null) {
      setState(() {
        userData = UserModel.fromJson(userMap);
        if (userData!.profileImage != null) {
          _image = File(userData!.profileImage!);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await UserDatabase.updateProfileImage(imageFile.path);

      setState(() {
        _image = imageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  profileProvider.pickImage(File(pickedFile.path));
                }
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: profileProvider.image != null
                    ? FileImage(profileProvider.image!)
                    : null,
                child: profileProvider.image == null
                    ? const Icon(Icons.account_circle,
                        size: 80, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard("Исм", userData?.fullName ?? "Номаълум"),
            _buildInfoCard("Фойдаланувчи номи", userData?.username ?? "Номаълум"),
            _buildInfoCard(
                "Телефон рақам", userData?.phoneNumber ?? "Номаълум"),
            _buildInfoCard("Статус", userData?.status ?? "Номаълум"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
