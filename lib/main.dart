import 'package:flutter/material.dart';
import 'package:truck_driver/view/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  ThemeMode? _themeMode;
  Locale _locale = Locale('uz');
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        Brightness systemBrightness = MediaQuery.platformBrightnessOf(context);
        ThemeMode effectiveThemeMode = _themeMode ??
            (systemBrightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: effectiveThemeMode,
          locale: Locale('uz'),
          supportedLocales: [
            Locale('uz'),
            Locale('eng')
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: LoginPage(onThemeChanged:(newMode){
            setState(() {
              _themeMode = newMode;
            });
          }),
        );
      },
    );
  }
}
