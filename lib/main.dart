
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/Finish.dart';
import 'package:flutter_yoga/Screens/SplashScreen.dart';
import 'package:flutter_yoga/Widgets/login_page.dart';
import 'package:flutter_yoga/Screens/Home.dart';
import 'package:flutter_yoga/Widgets/ProfilePage.dart';
import 'package:provider/provider.dart';
import 'Widgets/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Yoga App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Define the starting route
      routes: {
        '/': (context) => SplashScreen(), // Main home page
        '/login': (context) => LoginPage(), // Login page
        '/profile': (context) => ProfilePage(), // Profile page
        '/home': (context) => Home(),
      },
      theme: themeProvider.currentTheme,
    );
  }
}
