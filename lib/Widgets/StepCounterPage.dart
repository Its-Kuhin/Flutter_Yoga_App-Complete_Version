

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounterPage extends StatefulWidget {
  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  int _steps = 0;
  int _stepGoal = 10000; // Default goal of 10,000 steps per day
  bool _goalAchieved = false;

  final TextEditingController _goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStepGoal();
    _loadSteps();
  }

  // Load the saved step goal from SharedPreferences
  void _loadStepGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _stepGoal = prefs.getInt('stepGoal') ?? 10000;
    });
  }

  // Load the saved step count from SharedPreferences
  void _loadSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _steps = prefs.getInt('steps') ?? 0;
      _goalAchieved = _steps >= _stepGoal;
    });
  }

  // Save the steps in SharedPreferences
  void _saveSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps', _steps);
    setState(() {
      _goalAchieved = _steps >= _stepGoal;
    });
  }

  // Save the new goal in SharedPreferences
  void _saveNewGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('stepGoal', _stepGoal);
    Fluttertoast.showToast(msg: "Step goal updated to $_stepGoal steps.");
  }

  // Update the step count
  void _incrementSteps() {
    setState(() {
      _steps += 100;
    });
    _saveSteps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step Counter"),
        backgroundColor: Colors.blueAccent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth * 0.05;
          double fontSize = constraints.maxHeight * 0.025;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step Count Display
                _buildStepCount(fontSize),

                SizedBox(height: fontSize),

                // Progress Indicator
                _buildProgressIndicator(),

                SizedBox(height: fontSize),

                // Goal Status
                _buildGoalStatus(fontSize),

                SizedBox(height: fontSize * 2),

                // Increment Step Button
                _buildIncrementButton(constraints),

                SizedBox(height: fontSize * 2),

                // Goal Setting Section
                _buildGoalSetting(fontSize, padding),

                SizedBox(height: fontSize * 2),

                // Reset Button
                _buildResetButton(constraints),
              ],
            ),
          );
        },
      ),
    );
  }

  // Step Count Display Widget
  Widget _buildStepCount(double fontSize) {
    return Text(
      "Steps Today: $_steps",
      style: TextStyle(fontSize: fontSize * 1.2, fontWeight: FontWeight.bold),
    );
  }

  // Progress Indicator Widget
  Widget _buildProgressIndicator() {
    return LinearProgressIndicator(
      value: _steps / _stepGoal,
      backgroundColor: Colors.grey[300],
      color: _goalAchieved ? Colors.green : Colors.blueAccent,
      minHeight: 10,
    );
  }

  // Goal Status Widget
  Widget _buildGoalStatus(double fontSize) {
    return Text(
      _goalAchieved ? "Goal Achieved! Great job!" : "Keep going, you can do it!",
      style: TextStyle(
        fontSize: fontSize,
        color: _goalAchieved ? Colors.green : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Increment Step Button Widget
  Widget _buildIncrementButton(BoxConstraints constraints) {
    return ElevatedButton(
      onPressed: _incrementSteps,
      child: Text("Add 100 Steps"),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.3,
          vertical: constraints.maxHeight * 0.02,
        ),
      ),
    );
  }

  // Goal Setting Section
  Widget _buildGoalSetting(double fontSize, double padding) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Set Your Step Goal:",
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: padding),
        TextField(
          controller: _goalController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Enter your new goal",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: padding),
        ElevatedButton(
          onPressed: () {
            if (_goalController.text.isNotEmpty) {
              setState(() {
                _stepGoal = int.parse(_goalController.text);
              });
              _saveNewGoal();
            }
          },
          child: Text("Save New Goal"),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  // Reset Button Widget
  Widget _buildResetButton(BoxConstraints constraints) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _steps = 0;
        });
        _saveSteps();
        Fluttertoast.showToast(msg: "Step counter reset to 0.");
      },
      child: Text("Reset Steps"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.3,
          vertical: constraints.maxHeight * 0.02,
        ),
      ),
    );
  }
}
