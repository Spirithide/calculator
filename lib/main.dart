import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/result_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:provider/provider.dart';
import 'package:calculator/utils/themes.dart';
import 'package:calculator/ui/calculator_screen.dart';
import 'utils/database_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  DatabaseHelper databaseHelper = DatabaseHelper();
  databaseHelper.initializeDatabase();
  await FirebaseAuth.instance.signInAnonymously();
  
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ResultProvider>(
          create: (context) => ResultProvider(),
        ),
        ChangeNotifierProvider<HistoryProvider>(
          create: (context) => HistoryProvider(),
        ),
      ],
      child: MaterialApp(
          title: "Calculator",
          theme: Themes.basicTheme(),
          home: CalculatorScreen(),
          // home: LandingScreen(),
      ),
    );
  }
}
