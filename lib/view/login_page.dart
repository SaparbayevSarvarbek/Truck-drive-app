import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_localizations.dart';
import '../services/api_services.dart';
import '../view_model/login_view_model.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Consumer<LoginViewModel>(builder: (context, provider, child) {
              return Form(
                key: _formKey,
                child: Column(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Логин',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0),
                    ),
                    Text(
                      'Дастурга хуш келибсиз',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: 'Исм', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Илтимос исмингизни киртинг';
                        }
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          labelText: 'Парол',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Илтимос паролни киритинг';
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      width: provider.isLoading
                          ? 40
                          : MediaQuery.of(context).size.width,
                      height: provider.isLoading ? 40 : 50,
                      child: provider.isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                              ),
                              onPressed: () async {
                                bool isConnected = await checkInternet();
                                if (isConnected) {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginViewModel>().loginUser(
                                        _nameController.text,
                                        _passwordController.text,
                                        context);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Интернет мавжуд эмас")),
                                  );
                                }
                              },
                              child: Text(
                                'Кириш',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                    ),
                  ],
                ),
              );
            })));
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;

    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
