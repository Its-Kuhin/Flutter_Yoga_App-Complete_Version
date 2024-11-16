//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_yoga/services/localdb.dart';
//
// class ProfilePage extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = _auth.currentUser;
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text("User Profile"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.home, color:Colors.blueAccent),
//             onPressed: () {
//               Navigator.pushReplacementNamed(context, '/home');
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [ Color(0xFF270B19),Color(0xFF270B19),],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (user?.photoURL != null)
//                     CircleAvatar(
//                       radius: screenWidth * 0.15,
//                       backgroundImage: NetworkImage(user!.photoURL!),
//                     )
//                   else
//                     CircleAvatar(
//                       radius: screenWidth * 0.15,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.person, size: screenWidth * 0.15, color: Colors.blueAccent),
//                     ),
//                   SizedBox(height: screenHeight * 0.03),
//
//                   // User Info Card
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     color: Colors.white,
//                     elevation: 8,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Text(
//                             user?.displayName ?? 'No Name',
//                             style: TextStyle(
//                               fontSize: screenHeight * 0.03,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             user?.email ?? 'No Email',
//                             style: TextStyle(
//                               fontSize: screenHeight * 0.02,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: screenHeight * 0.03),
//
//                   // Activities Section
//                   Text(
//                     "Your Activities",
//                     style: TextStyle(
//                       fontSize: screenHeight * 0.025,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//
//                   // Display Streak and Surya Namaskar Details
//                   FutureBuilder<Map<String, dynamic>?>(
//                     future: getSuryaNamaskarDetails(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       }
//
//                       if (!snapshot.hasData || snapshot.data == null) {
//                         return Text(
//                           "No activities yet",
//                           style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.02),
//                         );
//                       }
//
//                       final exercise = snapshot.data!;
//
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         margin: EdgeInsets.symmetric(vertical: 8),
//                         color: Colors.white.withOpacity(0.9),
//                         child: ListTile(
//                           leading: Icon(Icons.fitness_center, color: Color(0xff6f86d6)),
//                           title: Text(
//                             exercise["title"],
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             "Date: ${exercise["date"]} • Duration: ${exercise["duration"]} • Times: ${exercise["times"]}",
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//
//                   SizedBox(height: screenHeight * 0.05),
//
//                   // Logout Button
//                   ElevatedButton.icon(
//                     onPressed: () async {
//                       await _auth.signOut();
//                       Navigator.pushReplacementNamed(context, '/login');
//                     },
//                     icon: Icon(Icons.logout, color:Color(0xFF270B19),),
//                     label: Text(
//                       "Logout",
//                       style: TextStyle(fontSize: screenHeight * 0.022),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: screenWidth * 0.15, vertical: screenHeight * 0.015),
//                       primary: Colors.blueAccent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Method to get Surya Namaskar details
//   Future<Map<String, dynamic>?> getSuryaNamaskarDetails() async {
//     int? currentStreak = await LocalDB.getStreak();
//
//     if (currentStreak != null && currentStreak > 0) {
//       // Fetch the Surya Namaskar workout details from Firestore
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .collection('exercises')
//           .where('title', isEqualTo: 'SuryaNamaskar')
//           .orderBy('date', descending: true)
//           .limit(1)
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         final exercise = snapshot.docs.first.data();
//         return {
//           'title': exercise['title'],
//           'date': exercise['date'],
//           'duration': exercise['duration'],
//           'times': exercise['times'],
//         };
//       }
//     }
//
//     return null;
//   }
// }
//

/////////////////////////////////////////

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/services/localdb.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("User Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.blueAccent),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF270B19), Color(0xFF270B19)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user?.photoURL != null)
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundImage: NetworkImage(user!.photoURL!),
                    )
                  else
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: screenWidth * 0.15, color: Colors.blueAccent),
                    ),
                  SizedBox(height: screenHeight * 0.03),

                  // User Info Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            user?.displayName ?? 'No Name',
                            style: TextStyle(
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            user?.email ?? 'No Email',
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Activities Section
                  Text(
                    "Your Activities",
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Hardcoded Activities List
                  FutureBuilder<int?>(
                    future: LocalDB.getStreak(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      int? streak = snapshot.data;
                      if (streak != null && streak == 0) {
                        return Column(
                          children: [
                            _buildActivityCard(
                              title: "Surya Namaskar",
                              date: "2024-11-10",
                              duration: "15 mins",
                              times: "3 times",
                            ),

                          ],
                        );
                      }
                      else if(streak != null && streak == 1){
                        return Column(
                          children: [
                            _buildActivityCard(
                              title: "Yoga Stretch",
                              date: "2024-11-11",
                              duration: "10 mins",
                              times: "5 times",
                            ),
                          ],
                        );

                      }
                      else if(streak != null && streak == 2){
                        return Column(
                          children: [
                            _buildActivityCard(
                              title: "Breathing Exercise",
                              date: "2024-11-12",
                              duration: "20 mins",
                              times: "2 times",
                            ),
                          ],
                        );

                      }
                      else {
                        return Text(
                          "No activities yet",
                          style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.02),
                        );
                      }
                    },
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Logout Button
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                      await LocalDB.setWorkOutTime(0);
                      await LocalDB.setkcal(0);
                      await LocalDB.setStreak(0);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    icon: Icon(Icons.logout, color: Color(0xFF270B19)),
                    label: Text(
                      "Logout",
                      style: TextStyle(fontSize: screenHeight * 0.022),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.15, vertical: screenHeight * 0.015),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method for Activity Card
  Widget _buildActivityCard({required String title, required String date, required String duration, required String times}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
        leading: Icon(Icons.fitness_center, color: Colors.blueAccent,),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Date: $date • Duration: $duration • Times: $times",
        ),
      ),
    );
  }
}
