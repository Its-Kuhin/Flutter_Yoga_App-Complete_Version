
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the LoginPage
import 'ProfilePage.dart'; // Import the ProfilePage for the user details page

class CustomAppBar extends StatelessWidget {
  final AnimationController animationController;
  final Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
  final Function()? onPressed;

  CustomAppBar({
    required this.animationController,
    required this.colorsTween,
    required this.drawerTween,
    required this.homeTween,
    required this.iconTween,
    required this.onPressed,
    required this.yogaTween,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser; // Get current user
    //String userName = user?.displayName ?? 'User'; // Default to 'User' if no name
   // String? photoUrl = user?.photoURL; // User's photo URL

    return Container(
      height: 100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: drawerTween.value,
            ),
            onPressed: onPressed,
          ),
          backgroundColor: colorsTween.value,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "HOME ",
                style: TextStyle(
                    color: homeTween.value,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "YOGA",
                style: TextStyle(
                    color: yogaTween.value,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          actions: [
            // Show profile icon only if user is logged in

            if (user != null)
              IconButton(
                icon: Icon(Icons.person_rounded,color: Color(0xFF270B19),),
                onPressed: () {
                  // Navigate to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
                  );
                },
                color: iconTween.value,
              ),
            // Show login icon if user is not logged in
            if (user == null)
              IconButton(
                icon: Icon(Icons.login,color: Color(0xFF270B19),),
                onPressed: () {
                  // Navigate to the login page if not logged in
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
                  );
                },
                color: iconTween.value,
              ),
          ],
        ),
      ),
    );
  }
}


