// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_yoga/Screens/rUready.dart';
// import 'package:flutter_yoga/services/yogadb.dart';
// import '../model/model.dart';
//
//
// class Startup extends StatefulWidget {
//   String Yogakey;
//   YogaSummary yogaSum;
//   Startup({required this.Yogakey, required this.yogaSum});
//
//   @override
//   _StartupState createState() => _StartupState();
// }
//
// class _StartupState extends State<Startup> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ReadAllYoga();
//   }
//
//   late List<Yoga> AllYogaWorkOuts;
//   bool isLoading =  true;
//   Future ReadAllYoga() async {
//     this.AllYogaWorkOuts =
//         await YogaDatabase.instance.readAllYoga(widget.yogaSum.YogaWorkOutName);
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading ? Scaffold(body: Container(),) : Scaffold(
//       backgroundColor:  Colors.white,
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => rUready(YogaTableName: widget.yogaSum.YogaWorkOutName,)));
//         },
//         child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//             child: Text(
//               "START",
//               style: TextStyle(fontSize: 20),
//             )),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.parallax,
//               title: Text(widget.yogaSum.YogaWorkOutName),
//               background: Image.asset(
//                 widget.yogaSum.BackImg.toString(),
//                 fit: BoxFit.cover,
//               ),
//             ),
//
//             //TODO: In Next Update - Add An Info Button About The Workout Pack
//             actions: [
//               IconButton(
//                   onPressed: () {
//
//
//                     showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: Text('Surya Namaskar'),
//                           actionsAlignment: MainAxisAlignment.center,
//                           actionsPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
//                           actions: [
//                             ElevatedButton(onPressed: (){
//                               Navigator.pop(context);
//                             }, child: Text("Close"))
//                           ],
//                           content: Container(
//
//
//
//                               child: Column(
//
//                                 children: [
//                                   Image.asset("assets/01_Suryanamskar/main.jpg"),
//                                   SizedBox(height: 10,),
//                                   Text('\nIntroduction to Surya Namaskar:\n\nSurya Namaskar, also known as Sun Salutation, holds a mystical place in the world of yoga(Ekam Yoga). It is derived from the ancient Vedic tradition and consists of twelve postures that pay homage to the Sun as it provides energy and health to all life on Earth. In this guide, we will see in detail how to do Surya Namaskar and how it affects your overall health.\n\nUnderstanding Surya Namaskar\nSurya Namaskar is a combination of physical postures (asanas), breath control (pranayama), and mindfulness that unites three aspects – mind, body, and spirit. The series includes each posture as well as specific breathing exercises to create a deeper bond between one is breath and inner self.' , textAlign: TextAlign.center, style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400),),
//
//                                 ],
//
//                               ),
//
//                           ),
//
//                     ));
//
//
//
//
//                   }, icon: Icon(Icons.help,color: Colors.blueAccent,))
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "${widget.yogaSum.TimeTaken} Mins || ${widget.yogaSum.TotalNoOfWork} Workouts",
//                         style: TextStyle(fontWeight: FontWeight.w400),
//                       )
//                     ],
//                   ),
//                   Divider(
//                     thickness: 2,
//                   ),
//                   ListView.separated(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       separatorBuilder: (context, index) => Divider(
//                             thickness: 2,
//                           ),
//
//                       itemBuilder: (context, index) => ListTile(
//                             leading: Container(
//                                 margin: EdgeInsets.only(right: 20),
//                                 child: Image.asset(
//                                   AllYogaWorkOuts[index].YogaImgUrl,
//                                   fit: BoxFit.cover,
//                                 )),
//                             title: Text(
//                               AllYogaWorkOuts[index].YogaTitle,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             subtitle: Text(
//                              AllYogaWorkOuts[index].Seconds ? "00:${AllYogaWorkOuts[index].SecondsOrTimes}" : "x${AllYogaWorkOuts[index].SecondsOrTimes}",
//                               style: TextStyle(fontSize: 15),
//                             ),
//                           ),
//                       itemCount: AllYogaWorkOuts.length)
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

///////////////////////////////////////////////////////////////////

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/rUready.dart';
import 'package:flutter_yoga/services/yogadb.dart';
import '../model/model.dart';

class Startup extends StatefulWidget {
  String Yogakey;
  YogaSummary yogaSum;
  Startup({required this.Yogakey, required this.yogaSum});

  @override
  _StartupState createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  late List<Yoga> AllYogaWorkOuts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ReadAllYoga();
  }

  Future ReadAllYoga() async {
    this.AllYogaWorkOuts = await YogaDatabase.instance.readAllYoga(widget.yogaSum.YogaWorkOutName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => rUready(YogaTableName: widget.yogaSum.YogaWorkOutName)),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "START",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Text(widget.yogaSum.YogaWorkOutName),
              background: Image.asset(
                widget.yogaSum.BackImg.toString(),
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('SuryaNamaskar',style:TextStyle(fontWeight: FontWeight.bold)),
                      actionsAlignment: MainAxisAlignment.center,
                      actionsPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"),
                        ),
                      ],
                      content: Column(
                        children: [
                          Image.network("https://ekamyoga.com/public/uploads/blog/1716359832.jpg"),
                          SizedBox(height: 10),
                          Text(
                            '\nIntroduction to Surya Namaskar\n',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\nSurya Namaskar, also known as Sun Salutation, holds a mystical place in the world of yoga (Ekam Yoga). It is derived from the ancient Vedic tradition and consists of twelve postures that pay homage to the Sun as it provides energy and health to all life on Earth. In this guide, we will see in detail how to do Surya Namaskar and how it affects your overall health.',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'RobotoSlab'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.help,color:Color(0xFF270B19)),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${widget.yogaSum.TimeTaken} Mins || ${widget.yogaSum.TotalNoOfWork} Workouts",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                      ),
                      itemBuilder: (context, index) => ListTile(
                        leading: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Image.asset(
                            AllYogaWorkOuts[index].YogaImgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          AllYogaWorkOuts[index].YogaTitle,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          AllYogaWorkOuts[index].Seconds ? "00:${AllYogaWorkOuts[index].SecondsOrTimes}" : "x${AllYogaWorkOuts[index].SecondsOrTimes}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      itemCount: AllYogaWorkOuts.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
