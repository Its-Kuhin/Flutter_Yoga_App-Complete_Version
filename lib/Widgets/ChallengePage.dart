import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  List<String> challenges = [
    "10,000 Steps Challenge",
    "30-Day Yoga Challenge",
    "No Sugar Week",
    "Running Challenge - 5k per week"
  ];

  TextEditingController _challengeController = TextEditingController();

  // Method to add a new challenge
  void _addChallenge() {
    if (_challengeController.text.isNotEmpty) {
      setState(() {
        challenges.add(_challengeController.text);
      });
      _challengeController.clear();
      Navigator.pop(context);
    }
  }

  // Method to delete a challenge
  void _deleteChallenge(int index) {
    setState(() {
      challenges.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Challenge deleted")),
    );
  }

  // Method to show a dialog for creating a new challenge
  void _showAddChallengeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create a New Challenge"),
          content: TextField(
            controller: _challengeController,
            decoration: InputDecoration(hintText: "Enter challenge name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: _addChallenge,
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // Method to navigate to challenge details
  void _viewChallengeDetails(String challenge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeDetailsPage(challenge: challenge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Challenges"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Challenge Button
            ElevatedButton(
              onPressed: _showAddChallengeDialog,
              child: Text("Create New Challenge"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: 15),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Challenges List
            Text(
              "Available Challenges:",
              style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteChallenge(index);
                    },
                    background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          challenges[index],
                          style: TextStyle(fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Join this challenge to stay fit!"),
                        onTap: () => _viewChallengeDetails(challenges[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeDetailsPage extends StatelessWidget {
  final String challenge;

  ChallengeDetailsPage({required this.challenge});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Challenge Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              challenge,
              style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Details about the challenge will go here. This is a great way to engage in fitness activities and track your progress.",
              style: TextStyle(fontSize: screenHeight * 0.02),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: () {
                // Logic to join the challenge goes here
                Navigator.pop(context);
              },
              child: Text("Join Challenge"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
