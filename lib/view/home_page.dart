import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_driver/models/user_model.dart';
import 'package:truck_driver/theme/my_dialog.dart';
import 'package:truck_driver/view/complaint_page.dart';
import 'package:truck_driver/view/expenses_page.dart';
import 'package:truck_driver/view/history_page.dart';
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
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userMap = await UserDatabase.getUser();
    if (userMap != null) {
      userData = UserModel.fromJson(userMap);
      setState(() {
        userId = userData?.id;
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
    final expenseColor = isDark ? Colors.teal : Colors.blueAccent;
    Brightness systemBrightness = MediaQuery.platformBrightnessOf(context);
    ThemeMode effectiveTheme = _selectedTheme ??
        (systemBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light);
    return Scaffold(
      appBar: AppBar(
        title: Text('Асосий саҳифа'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16.0,
          children: [
            Lottie.asset(
              'assets/lottie/truck.json',
              width: MediaQuery.of(context).size.width,
              height: 260,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bunyod truck',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 350),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ExpensesPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: expenseColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Чиқимлар',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ComplaintPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: expenseColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Аризалар',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HistoryPage(
                        userId: userId!,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: expenseColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Тарих',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        profileProvider.pickImage(File(pickedFile.path));
                      }
                    },
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: profileProvider.image != null
                          ? FileImage(profileProvider.image!)
                          : null,
                      child: profileProvider.image == null
                          ? const Icon(
                              Icons.account_circle,
                              size: 60,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(userData?.fullName ?? "Ism yo'q",
                      style: TextStyle(fontSize: 18)),
                  Text(
                    userData?.phoneNumber ?? "Telefon yo'q",
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
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
                ),
                title: Text(rejim),
                trailing: Switch.adaptive(
                  value: isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
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
              ),
              title: Text("Чиқиш"),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                MyDialog.info('Аккаунтдан чиқдингиз');
              },
            ),
          ],
        ),
      ),
    );
  }
}
