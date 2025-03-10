import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/app_localizations.dart';

class HomePage extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  HomePage({required this.onThemeChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode? _selectedTheme;
  String rejim = 'Dark';
  bool isUzbek = true;

  @override
  Widget build(BuildContext context) {
    Brightness systemBrightness = MediaQuery.platformBrightnessOf(context);
    ThemeMode effectiveTheme = _selectedTheme ??
        (systemBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Chiqimlar')))),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context)!
                            .translate("application"))))),
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
                    Icon(Icons.account_circle, size: 60, color: Colors.white),
                    SizedBox(height: 10),
                    Text(AppLocalizations.of(context)!.translate("username"),
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text("driver@example.com",
                        style: TextStyle(color: Colors.white70)),
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.indigo,
              ),
              title: Text(AppLocalizations.of(context)!.translate("profile")),
              onTap: () {},
            ),
            ListTile(
                leading: Icon(
                  Icons.brightness_6,
                  color: Colors.indigo,
                ),
                title: Text(rejim),
                trailing: Switch.adaptive(
                  value: effectiveTheme == ThemeMode.dark,
                  onChanged: (bool isDark) {
                    setState(() {
                      _selectedTheme =
                          isDark ? ThemeMode.dark : ThemeMode.light;
                      isDark
                          ? rejim =
                              AppLocalizations.of(context)!.translate("dark")
                          : rejim =
                              AppLocalizations.of(context)!.translate("light");
                    });
                    widget.onThemeChanged(_selectedTheme!);
                  },
                )),
            ListTile(
              leading: Icon(
                Icons.translate,
                color: Colors.indigo,
              ),
              title: Text(
                  AppLocalizations.of(context)!.translate("change_language")),
              trailing: Switch(
                  value: isUzbek,
                  onChanged: (value) {
                    isUzbek = value;
                    Locale newLocale = isUzbek ? Locale("uz") : Locale("en");
                    MyApp.setLocale(context, newLocale);
                  }),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.indigo,
              ),
              title: Text(AppLocalizations.of(context)!.translate("logout")),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
