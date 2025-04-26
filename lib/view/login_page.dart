import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/theme/my_dialog.dart';
import '../view_model/login_view_model.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).brightness == Brightness.dark
        ? Colors.teal
        : Colors.blue;
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
                        prefixIcon: Icon(Icons.person, color: color),
                        labelText: 'Исм',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Илтимос исмингизни киртинг';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Парол',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: color,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: color,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                        ),
                      ),
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
                                backgroundColor: color,
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
                                  MyDialog.error('Интернет мавжуд эмас');
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
