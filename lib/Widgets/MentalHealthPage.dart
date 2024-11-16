import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MentalHealthPage extends StatefulWidget {
  @override
  _MentalHealthPageState createState() => _MentalHealthPageState();
}

class _MentalHealthPageState extends State<MentalHealthPage> {
  // List of moods
  final List<String> moodOptions = ["Happy", "Stressed", "Anxious", "Sad", "Excited", "Calm"];

  // Controller for the rating scale
  TextEditingController _moodRatingController = TextEditingController();

  // Variable to track the user's selected mood and rating
  String? selectedMood;
  double moodRating = 0.0;

  // Placeholder for saved mood data (to be replaced with real data storage later)
  List<Map<String, dynamic>> moodHistory = [];

  // Save the mood check-in
  void _saveMoodCheckIn() {
    setState(() {
      moodHistory.add({
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'mood': selectedMood,
        'rating': moodRating,
      });
    });
    Fluttertoast.showToast(msg: 'Mood Recorded', toastLength: Toast.LENGTH_SHORT);
  }

  // Suggest activity based on mood
  String _getSuggestedActivity() {
    if (selectedMood == "Stressed" || selectedMood == "Anxious") {
      return "Try a 5-minute meditation or deep breathing exercise!";
    } else if (selectedMood == "Sad") {
      return "Listen to your favorite music or take a walk outside!";
    } else if (selectedMood == "Excited") {
      return "Use that energy for a fun workout or start a new project!";
    } else if (selectedMood == "Happy") {
      return "Keep spreading positivity! You could help others today.";
    } else {
      return "Stay calm and centered. Take a few deep breaths.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Health Check-in"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Selection
            Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Mood dropdown
            DropdownButton<String>(
              value: selectedMood,
              hint: Text("Select Mood"),
              items: moodOptions.map((String mood) {
                return DropdownMenuItem<String>(
                  value: mood,
                  child: Text(mood),
                );
              }).toList(),
              onChanged: (String? newMood) {
                setState(() {
                  selectedMood = newMood;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.03),

            // Mood rating slider
            Text(
              "Rate your mood (0 - 10):",
              style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: moodRating,
              min: 0.0,
              max: 10.0,
              divisions: 10,
              label: moodRating.round().toString(),
              onChanged: (double newRating) {
                setState(() {
                  moodRating = newRating;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.03),

            // Save button
            ElevatedButton(
              onPressed: selectedMood != null ? _saveMoodCheckIn : null,
              child: Text("Save Mood Check-in"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: 15),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Suggested Activity
            if (selectedMood != null)
              Text(
                "Suggested Activity: ${_getSuggestedActivity()}",
                style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.blueAccent),
              ),
            SizedBox(height: screenHeight * 0.05),

            // Mood History (Trends)
            Text(
              "Mood History:",
              style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Display mood history
            Expanded(
              child: ListView.builder(
                itemCount: moodHistory.length,
                itemBuilder: (context, index) {
                  var moodEntry = moodHistory[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("${moodEntry['mood']} - Rating: ${moodEntry['rating']}"),
                      subtitle: Text("Date: ${moodEntry['date']}"),
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
