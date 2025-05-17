import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/theme/theme.dart';
import 'package:truck_driver/view/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:truck_driver/view/splash_screen_page.dart';
import 'package:truck_driver/view_model/complaint_view_model.dart';
import 'package:truck_driver/view_model/debt_view_model.dart';
import 'package:truck_driver/view_model/expenses_view_model.dart';
import 'package:truck_driver/view_model/history_viewmodel.dart';
import 'package:truck_driver/view_model/login_view_model.dart';
import 'package:truck_driver/view_model/profile_provider.dart';
import 'package:truck_driver/view_model/theme_provider.dart';
import 'models/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesViewModel()),
        ChangeNotifierProvider(create: (_) => ComplaintViewModel()),
        ChangeNotifierProvider(create: (_) => HistoryViewModel()),
        ChangeNotifierProvider(create: (_) => DebtViewModel()),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: MyApp(),
    ),
  );
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
  Locale _locale = const Locale('uz');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      locale: _locale,
      supportedLocales: [const Locale('uz'), const Locale('eng')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SplashScreenPage(),
    );
  }
}
