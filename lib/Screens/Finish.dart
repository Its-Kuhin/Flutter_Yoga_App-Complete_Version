// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
//
// import '../services/localdb.dart';
//
//
// class Finish extends StatelessWidget {
//   const Finish({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider <UpdateFitnessModel>(
//       create: (context)=>UpdateFitnessModel(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//             child: Column(
//
//               children: [
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.network("https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY=" , width: 350, height: 350,)
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 13 , horizontal: 50),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Text("125" , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),),
//                           Text("KCal" , style :TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),)
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Text("12" , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),),
//                           Text("Minutes" , style :TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),)
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.zero, // Remove default padding to make gradient fit
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30), // Rounded corners
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: Ink(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Colors.lightBlueAccent, Colors.lightBlueAccent], // Gradient colors
//                               begin: Alignment.centerLeft,
//                               end: Alignment.centerRight,
//                             ),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width - 230,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.repeat, color: Colors.white, size: 18), // Add an icon
//                                 const SizedBox(width: 3),
//                                 Text(
//                                   "DO IT AGAIN",
//                                   style: TextStyle(
//                                     fontSize: 15, // Make the text larger for better visibility
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                       ,
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.zero, // Remove default padding to make gradient fit
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30), // Rounded corners
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: Ink(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Colors.lightBlueAccent, Colors.lightBlueAccent], // Gradient colors
//                               begin: Alignment.centerLeft,
//                               end: Alignment.centerRight,
//                             ),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width - 230,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.share, color: Colors.white, size: 18), // Add an icon
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   "SHARE",
//                                   style: TextStyle(
//                                     fontSize: 16, // Make the text larger for better visibility
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                       // Text("DO IT AGAIN" ,style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 15 ),),
//                       //Text("SHARE" ,style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 15 ),),
//                     ],
//                   ),
//                 ),
//                 Divider(thickness: 2,),
//                 Container(
//                   child: Column(
//                     children: [
//
//                       ElevatedButton(onPressed: (){}, child: Container(
//                         width: MediaQuery.of(context).size.width - 70,
//                         padding: const EdgeInsets.all(18.0),
//                         child: Text("RATE OUR APP" , style: TextStyle(fontSize: 20) , textAlign: TextAlign.center,),
//                       ))
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 30,),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 200,
//                   color: Colors.white,
//                 ),
//                 Consumer<UpdateFitnessModel>(
//                   builder: (context , myModel , child){
//                     return  Container();
//                   },
//
//                 )
//               ],
//             )
//         ),
//       ),
//     );
//   }
// }
//
//
// class UpdateFitnessModel with ChangeNotifier{
// UpdateFitnessModel(){
//   print("IT WORKS");
//   SetWorkoutTime();
//   LastWorkOutDoneOn();
//   SetMyKCAL(13);
// }
// int a = 1;
//
//   void SetWorkoutTime() async{
//
//     print("SetWorkoutTime");
// String? StartTime = await LocalDB.getStartTime();
//     DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(StartTime ?? "2022-05-24 19:31:15.182");
// int difference = DateTime.now().difference(tempDate).inMinutes;
// int? mywotime = await LocalDB.getWorkOutTime();
// print(mywotime);
// // LocalDB.setWorkOutTime( mywotime! + 59);
// LocalDB.setWorkOutTime( mywotime! + difference);
//
//   }
//
//
//   void LastWorkOutDoneOn() async{
// print("LAST WORKOUT DONE");
//
//
//     DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(await LocalDB.getLastDoneOn() ?? "2022-05-24 19:31:15.182");
//     int difference = DateTime.now().difference(tempDate).inDays;
//     if(difference == 0){
//       print("GOOD JOB");
//
//
//     }else{
//       int? streaknow = await LocalDB.getStreak();
//       LocalDB.setStreak( streaknow! +  1);
//
//     }
//
// await LocalDB.setLastDoneOn(DateTime.now().toString());
//   }
//
//
//   void SetMyKCAL(int myKCAL) async{
//     print("SetMyKCAL");
//     int? kcal = await LocalDB.getKcal();
//     print(kcal);
//     LocalDB.setkcal(kcal.toString() == "null" ? 0  : kcal! + myKCAL);
//
//   }
// //TODO: Set the initial value of straek and lastdone on in starting of app
// }

///////////////////////////////////////////////////////////


import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/localdb.dart';
import 'home.dart'; // Assuming your home page is Home.dart

class Finish extends StatelessWidget {
  const Finish({Key? key}) : super(key: key);

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Hey I am using Yoga For Beginners App',
        text: 'Hey I am using Yoga For Beginners App. It has best yoga workout for all age groups. You should try it once.',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateFitnessModel>(
      create: (context) => UpdateFitnessModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Finish Workout"),
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {



                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(

                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY=",
                      width: 350,
                      height: 350,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "125",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "KCal",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "12",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Minutes",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to the Home Page when the home button is pressed
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Home()), // HomePage is your main home page
                        );
                        // Perform any action you want for the "Do It Again" button
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightBlueAccent, Colors.lightBlueAccent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 230,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.repeat, color: Colors.white, size: 18),
                              const SizedBox(width: 3),
                              Text(
                                "DO IT AGAIN",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        shareApp;
                        // Perform any action you want for the "Share" button
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightBlueAccent, Colors.lightBlueAccent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 230,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                "SHARE",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2),
              Container(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                        await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.dhruv.aiem"));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 70,
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "RATE OUR APP",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class UpdateFitnessModel with ChangeNotifier {
  UpdateFitnessModel() {
    print("UpdateFitnessModel initialized.");
    setWorkoutTime();
    lastWorkOutDoneOn();
    setMyKCAL(13);
  }

  Future<void> setWorkoutTime() async {
    print("Setting workout time...");
    String? startTime = await LocalDB.getStartTime();
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(startTime ?? "2022-05-24 19:31:15.182");
    int difference = DateTime.now().difference(tempDate).inMinutes;
    int? workoutTime = await LocalDB.getWorkOutTime();
    await LocalDB.setWorkOutTime((workoutTime ?? 0) + difference);
  }

  Future<void> lastWorkOutDoneOn() async {
    try {
      print("Checking last workout date...");
      String? lastDoneOn = await LocalDB.getLastDoneOn();
      DateTime tempDate = lastDoneOn != null
          ? DateFormat("yyyy-MM-dd hh:mm:ss").parse(lastDoneOn)
          : DateTime.now();

      int difference = DateTime.now().difference(tempDate).inDays;

      if (difference == 0) {
        print("Good job! You worked out today.");
      } else {
        int currentStreak = (await LocalDB.getStreak()) ?? 0;
        await LocalDB.setStreak(currentStreak + 1);
        print("Streak updated to ${currentStreak + 1}");
      }

      await LocalDB.setLastDoneOn(DateTime.now().toString());
    } catch (e) {
      print("Error in updating last workout date: $e");
    }
  }

  Future<void> setMyKCAL(int myKCAL) async {
    print("Updating KCAL...");
    int? kcal = await LocalDB.getKcal();
    await LocalDB.setkcal((kcal ?? 0) + myKCAL);
  }
}

