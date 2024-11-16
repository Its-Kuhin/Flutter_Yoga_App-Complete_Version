
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/Widgets/theme_provider.dart';
import 'package:flutter_yoga/services/localdb.dart';
import 'package:provider/provider.dart';
import 'BMICalculatorPage.dart';
import 'CalorieCalculatorPage.dart';
import 'SleepTrackerPage.dart';
import 'WaterIntakeCalculatorPage.dart';
import 'GoalSettingPage.dart';
import 'ChallengePage.dart';
import 'MentalHealthPage.dart';
import 'StepCounterPage.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Color(0xFF1F1F1F) : Colors.blueAccent,
        elevation: 0,
        title: Text(
          user?.displayName ?? 'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          // Theme Toggle Switch
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Color(0xFF1F1F1F), Color(0xFF121212)]
                : [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              // Profile Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.10,
                        backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                        child: user?.photoURL == null
                            ? Icon(Icons.person, size: screenWidth * 0.15, color: Colors.blueAccent)
                            : null,
                      ),
                      SizedBox(height: 15),
                      Text(
                        user?.displayName ?? 'No Name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user?.email ?? 'No Email',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Activities Section
              Text(
                "Your Activities",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              FutureBuilder<int?>(
                future: LocalDB.getStreak(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  int? streak = snapshot.data;
                  return Column(
                    children: [
                      _buildActivityCard(
                        title: "Surya Namaskar",
                        date: "2024-11-10",
                        duration: "15 mins",
                        times: "3 times",
                      ),
                      SizedBox(height: 10),
                      _buildActivityCard(
                        title: "Yoga Stretch",
                        date: "2024-11-11",
                        duration: "10 mins",
                        times: "5 times",
                      ),
                      SizedBox(height: 10),
                      if (streak != null)
                        Text(
                          'Current Streak: $streak days',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),

              // Feature Icons Row 1
              _buildFeatureRow(context, [
                _buildFeatureIcon(context, Icons.accessibility_new, "BMI Calculator", BMICalculatorPage()),
                _buildFeatureIcon(context, Icons.directions_walk, "Step Counter", StepCounterPage()),
                _buildFeatureIcon(context, Icons.local_drink, "Water Intake", WaterIntakeCalculatorPage()),
                _buildFeatureIcon(context, Icons.mood, "Mental Health", MentalHealthPage()),
              ]),
              SizedBox(height: 20),

              // Feature Icons Row 2
              _buildFeatureRow(context, [
                _buildFeatureIcon(context, Icons.restaurant, "Calorie Calculator", CalorieCalculatorPage()),
                _buildFeatureIcon(context, Icons.flag, "Goal Setting", GoalSettingPage()),
                _buildFeatureIcon(context, Icons.bedtime, "Sleep Tracker", SleepTrackerPage()),
                _buildFeatureIcon(context, Icons.star, "Challenges", ChallengePage()),
              ]),
              SizedBox(height: 30),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  await LocalDB.setWorkOutTime(0);
                  await LocalDB.setkcal(0);
                  await LocalDB.setStreak(0);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: 15),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method for Activity Card
  Widget _buildActivityCard({required String title, required String date, required String duration, required String times}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: $date'),
            Text('Duration: $duration'),
            Text('Times: $times'),
          ],
        ),
      ),
    );
  }

  // Helper Method for Feature Icon
  Widget _buildFeatureIcon(BuildContext context, IconData icon, String tooltip, Widget page) {
    return IconButton(
      icon: Icon(icon, size: 30, color: Colors.white),
      tooltip: tooltip,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  // Helper Method for Feature Row
  Widget _buildFeatureRow(BuildContext context, List<Widget> icons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons,
    );
  }
}

