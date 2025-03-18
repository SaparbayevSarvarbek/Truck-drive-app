import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/models/user_model.dart';
import 'package:truck_driver/view/expenses_page.dart';
import 'package:truck_driver/view/login_page.dart';
import 'package:truck_driver/view/profil_page.dart';

import '../main.dart';
import '../models/app_localizations.dart';
import '../models/user_database.dart';
import '../view_model/profile_provider.dart';
import '../view_model/theme_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode? _selectedTheme;
  String rejim = 'Кундузги режим';
  bool isUzbek = true;
  File? _image;
  UserModel? userData;

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark;
    final profileProvider = Provider.of<ProfileProvider>(context);
    Brightness systemBrightness = MediaQuery.platformBrightnessOf(context);
    ThemeMode effectiveTheme = _selectedTheme ??
        (systemBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light);
    return Scaffold(
      appBar: AppBar(
        title: Text('Асосий саҳифа'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.0,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) => ExpensesPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Чиқимлар')))),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Аризалар')))),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        profileProvider.pickImage(File(pickedFile.path));
                      }
                    },
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      backgroundImage: profileProvider.image != null ? FileImage(profileProvider.image!) : null,
                      child: profileProvider.image == null
                          ? const Icon(Icons.account_circle, size: 60, color: Colors.white)
                          : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(userData?.fullName ?? "Ism yo'q", style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(userData?.phoneNumber ?? "Telefon yo'q", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.indigo,
              ),
              title: Text(AppLocalizations.of(context)!.translate("Профил")),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.brightness_6,
                  color: Colors.indigo,
                ),
                title: Text(rejim),
                trailing: Switch.adaptive(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      themeProvider.toggleTheme(value);
                      _selectedTheme =
                          isDark ? ThemeMode.dark : ThemeMode.light;
                      isDark ? rejim = "Кундузги режим" : rejim = "Кечки режим";
                    });
                    // widget.onThemeChanged(_selectedTheme!);
                  },
                )),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.indigo,
              ),
              title: Text("Чиқиш"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
