
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
    String userName = user?.displayName ?? 'User'; // Default to 'User' if no name
    String? photoUrl = user?.photoURL; // User's photo URL

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

///////////////////////////////////////////////

//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'login_page.dart';
// import 'ProfilePage.dart';
//
// class CustomAppBar extends StatelessWidget {
//   final AnimationController animationController;
//   final Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
//   final Function()? onPressed;
//
//   CustomAppBar({
//     required this.animationController,
//     required this.colorsTween,
//     required this.drawerTween,
//     required this.homeTween,
//     required this.iconTween,
//     required this.onPressed,
//     required this.yogaTween,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String userName = user?.displayName ?? 'Guest';
//     String? photoUrl = user?.photoURL;
//
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.12,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: AnimatedBuilder(
//         animation: animationController,
//         builder: (context, child) {
//           return AppBar(
//             leading: IconButton(
//               icon: Icon(Icons.dehaze, color: drawerTween.value),
//               onPressed: onPressed,
//             ),
//             backgroundColor: colorsTween.value,
//             elevation: 0,
//             title: Row(
//               children: [
//                 Text(
//                   "HOME ",
//                   style: TextStyle(
//                     color: homeTween.value,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                 ),
//                 Text(
//                   "YOGA",
//                   style: TextStyle(
//                     color: yogaTween.value,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               // Display greeting with the user's name
//               if (user != null)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: Text(
//                     "Hello, $userName!",
//                     style: TextStyle(
//                       color: iconTween.value,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               // Profile Picture or Default Icon
//               GestureDetector(
//                 onTap: () {
//                   if (user != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ProfilePage()),
//                     );
//                   } else {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   }
//                 },
//                 child: CircleAvatar(
//                   backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
//                   child: photoUrl == null ? Icon(Icons.person, color: iconTween.value) : null,
//                   backgroundColor: Colors.grey.shade200,
//                   radius: 18,
//                 ),
//               ),
//               const SizedBox(width: 10),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

//////////////////////////////////////////////////////


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'CustomDrawer.dart';
// import 'login_page.dart';
// import 'ProfilePage.dart';
//
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final AnimationController animationController;
//   final Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
//   final Function()? onPressed;
//
//   CustomAppBar({
//     required this.animationController,
//     required this.colorsTween,
//     required this.drawerTween,
//     required this.homeTween,
//     required this.iconTween,
//     required this.onPressed,
//     required this.yogaTween,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String userName = user?.displayName ?? 'Guest';
//     String? photoUrl = user?.photoURL;
//
//     return AppBar(
//       leading: IconButton(
//         icon: Icon(Icons.dehaze, color: drawerTween.value),
//         onPressed: () {
//           // Navigate to Custom Drawer Page
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CustomDrawer()), // Navigate to the custom page
//           );
//         },
//       ),
//       backgroundColor: colorsTween.value,
//       elevation: 0,
//       title: Row(
//         children: [
//           Text(
//             "HOME ",
//             style: TextStyle(
//               color: homeTween.value,
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//           ),
//           Text(
//             "YOGA",
//             style: TextStyle(
//               color: yogaTween.value,
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         if (user != null)
//           Padding(
//             padding: const EdgeInsets.only(right:10),
//             child: Text(
//               "Hello, $userName!",
//               style: TextStyle(
//                 color: iconTween.value,
//                 fontSize:10,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         GestureDetector(
//           onTap: () {
//             if (user != null) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()),
//               );
//             } else {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             }
//           },
//           child: CircleAvatar(
//             backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
//             child: photoUrl == null ? Icon(Icons.person, color: iconTween.value) : null,
//             backgroundColor: Colors.grey.shade200,
//             radius: 18,
//           ),
//         ),
//         const SizedBox(width: 10),
//       ],
//     );
//   }
//
//   // Required for PreferredSizeWidget
//   @override
//   Size get preferredSize => const Size.fromHeight(56);
// }
