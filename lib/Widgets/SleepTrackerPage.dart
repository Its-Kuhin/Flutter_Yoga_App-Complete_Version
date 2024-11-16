import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SleepTrackerPage extends StatefulWidget {
  @override
  _SleepTrackerPageState createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String _sleepDuration = '';

  // Function to show a time picker dialog
  Future<void> _pickTime(TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select Time',
    );

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  // Function to calculate sleep duration
  void _calculateSleepDuration() {
    try {
      final startTime = DateFormat.jm().parse(_startTimeController.text);
      final endTime = DateFormat.jm().parse(_endTimeController.text);
      final endTimeAdjusted = endTime.isBefore(startTime) ? endTime.add(Duration(days: 1)) : endTime;
      final duration = endTimeAdjusted.difference(startTime);

      setState(() {
        _sleepDuration = '${duration.inHours} hours and ${duration.inMinutes % 60} minutes';
      });
    } catch (e) {
      setState(() {
        _sleepDuration = 'Please enter valid times.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Tracker'),
        backgroundColor: Color(0xFF512DA8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9575CD), Color(0xFF673AB7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Select Your Sleep Times',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // Start Time Picker
                      TextField(
                        readOnly: true,
                        controller: _startTimeController,
                        onTap: () => _pickTime(_startTimeController),
                        decoration: InputDecoration(
                          labelText: 'Sleep Start Time',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(Icons.access_time, color: Color(0xFF512DA8)),
                        ),
                      ),
                      SizedBox(height: 20),
                      // End Time Picker
                      TextField(
                        readOnly: true,
                        controller: _endTimeController,
                        onTap: () => _pickTime(_endTimeController),
                        decoration: InputDecoration(
                          labelText: 'Sleep End Time',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(Icons.access_time, color: Color(0xFF512DA8)),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Calculate Button
                      ElevatedButton(
                        onPressed: _calculateSleepDuration,
                        child: Text('Calculate Sleep Duration'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF673AB7),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Display Sleep Duration
              if (_sleepDuration.isNotEmpty)
                Card(
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Your Sleep Duration',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _sleepDuration,
                          style: TextStyle(fontSize: 24, color: Color(0xFF673AB7), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        _buildSleepMessage(),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to display sleep recommendation message
  Widget _buildSleepMessage() {
    final durationParts = _sleepDuration.split(' ');
    final hours = int.tryParse(durationParts[0]) ?? 0;

    if (hours < 6) {
      return Text(
        'Try to get at least 7-9 hours of sleep for better health.',
        style: TextStyle(color: Colors.redAccent),
        textAlign: TextAlign.center,
      );
    } else if (hours < 8) {
      return Text(
        'You are getting a healthy amount of sleep. Well done!',
        style: TextStyle(color: Colors.green),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        'Excellent! You are getting enough rest to recharge.',
        style: TextStyle(color: Colors.teal),
        textAlign: TextAlign.center,
      );
    }
  }
}
