import 'package:flutter/material.dart';

class GoalSettingPage extends StatefulWidget {
  @override
  _GoalSettingPageState createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  // Controllers to store user inputs
  TextEditingController _hydrationController = TextEditingController();
  TextEditingController _exerciseController = TextEditingController();
  TextEditingController _sleepController = TextEditingController();

  // Default goal values
  double hydrationGoal = 0.0;
  double exerciseGoal = 0.0;
  double sleepGoal = 0.0;

  // Progress tracking variables
  double hydrationProgress = 0.0;
  double exerciseProgress = 0.0;
  double sleepProgress = 0.0;

  // Save goals (local storage, Firebase, etc.)
  void _saveGoals() {
    setState(() {
      hydrationGoal = double.tryParse(_hydrationController.text) ?? 0.0;
      exerciseGoal = double.tryParse(_exerciseController.text) ?? 0.0;
      sleepGoal = double.tryParse(_sleepController.text) ?? 0.0;
    });
    _clearFields();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Goals Saved')));
  }

  // Clear text fields
  void _clearFields() {
    _hydrationController.clear();
    _exerciseController.clear();
    _sleepController.clear();
  }

  // Method to track progress (could be updated based on activities, e.g., steps, water intake)
  void _updateProgress(String goalType, double progress) {
    setState(() {
      if (goalType == "hydration") {
        hydrationProgress = progress;
      } else if (goalType == "exercise") {
        exerciseProgress = progress;
      } else if (goalType == "sleep") {
        sleepProgress = progress;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Set Your Goals"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: SingleChildScrollView(  // Added for better scroll handling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hydration Goal
              Text(
                "Hydration Goal (Liters):",
                style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _hydrationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your daily hydration goal",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Exercise Goal
              Text(
                "Exercise Goal (Minutes):",
                style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _exerciseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your daily exercise goal",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Sleep Goal
              Text(
                "Sleep Goal (Hours):",
                style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _sleepController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your sleep goal",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Save Goals Button
              ElevatedButton(
                onPressed: _saveGoals,
                child: Text("Save Goals"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: 15),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Progress Display
              Text(
                "Your Goal Progress:",
                style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Hydration Progress
              _buildProgressCard("Hydration", hydrationGoal, hydrationProgress),
              SizedBox(height: screenHeight * 0.02),

              // Exercise Progress
              _buildProgressCard("Exercise", exerciseGoal, exerciseProgress),
              SizedBox(height: screenHeight * 0.02),

              // Sleep Progress
              _buildProgressCard("Sleep", sleepGoal, sleepProgress),
              SizedBox(height: screenHeight * 0.05),

              // Reminder setup (optional)
              ElevatedButton(
                onPressed: () {
                  // Implement reminder setup here
                },
                child: Text("Set Reminders"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build progress cards for each goal
  Widget _buildProgressCard(String goalType, double goal, double progress) {
    // Avoid division by zero by checking if goal is 0
    double progressPercentage = goal > 0 ? (progress / goal) * 100 : 0;
    if (progressPercentage > 100) progressPercentage = 100; // Cap at 100%

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          "$goalType Goal Progress",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Goal: $goal", style: TextStyle(fontSize: 16)),
            Text("Progress: $progress", style: TextStyle(fontSize: 16)),
            LinearProgressIndicator(
              value: goal > 0 ? (progress / goal) : 0, // Handle division by zero
              color: Colors.blueAccent,
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(height: 8),
            Text("${progressPercentage.toStringAsFixed(1)}% Completed"),
          ],
        ),
      ),
    );
  }

}
