import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_yoga/Screens/SplashScreen.dart';
import 'package:flutter_yoga/services/localdb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> shareApp() async {
    await FlutterShare.share(
      title: 'Yoga For Beginners App',
      text:
      'I am using Yoga For Beginners App. It offers the best yoga workouts for all age groups. Check it out!',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Share Yoga App',
    );
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: Column(
        children: [
          // User Info Section
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2979FF), Color(0xFF75C2FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              user?.displayName ?? "Guest User",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              user?.email ?? "No Email Available",
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : AssetImage("assets/logo/default_avatar.png") as ImageProvider,
            ),
          ),

          // Reset Progress
          ListTile(
            title: Text(
              "Reset Progress",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.restart_alt_sharp, size: 25, color: Colors.redAccent),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF2A2A3C),
                  title: Text(
                    'RESET PROGRESS',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    'This will reset all your fitness data. This action cannot be undone.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await LocalDB.setWorkOutTime(0);
                        await LocalDB.setkcal(0);
                        await LocalDB.setStreak(0);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SplashScreen()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Progress Reset Successfully")),
                        );
                      },
                      child: Text("Reset"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    ),
                  ],
                ),
              );
            },
          ),

          // Share with Friends
          ListTile(
            title: Text(
              "Share With Friends",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.share, size: 25, color: Colors.greenAccent),
            onTap: shareApp,
          ),

          // Rate Us
          ListTile(
            title: Text(
              "Rate Us",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.star, size: 25, color: Colors.amber),
            onTap: () async {
              await _launchUrl("https://play.google.com/store/apps");
            },
          ),

          // Privacy Policy
          ListTile(
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.security, size: 25, color: Colors.blueAccent),
            onTap: () async {
              await _launchUrl("https://play.google.com/store/apps");
            },
          ),

          // Custom Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              thickness: 1.5,
              color: Colors.white24,
            ),
          ),

          // App Version
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Version 1.0.0",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}

class _launchUrl {
  _launchUrl(String s);
}
