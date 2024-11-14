
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/Finish.dart';
import 'package:flutter_yoga/Screens/SplashScreen.dart';
import 'Widgets/login_page.dart';
import 'Screens/Home.dart';  // Import your Home widget
import 'Widgets/ProfilePage.dart'; // Import ProfilePage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}





