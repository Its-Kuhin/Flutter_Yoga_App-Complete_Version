import 'package:flutter/material.dart';

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _height = 0.0;
  double _weight = 0.0;
  double _bmi = 0.0;
  String _category = '';
  String _message = '';

  // Function to calculate BMI
  void _calculateBMI() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _bmi = _weight / (_height * _height);
        if (_bmi < 18.5) {
          _category = 'Underweight';
          _message = 'You are underweight. Consider checking our "Yoga for weight gain" category.';
        } else if (_bmi >= 18.5 && _bmi < 24.9) {
          _category = 'Normal weight';
          _message = 'You have a healthy weight. Keep it up!';
        } else if (_bmi >= 25 && _bmi < 29.9) {
          _category = 'Overweight';
          _message = 'Consider adopting a healthier lifestyle with more physical activity.';
        } else {
          _category = 'Obese';
          _message = 'Consult a healthcare provider to discuss a proper weight management plan.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  "Enter Your Details",
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Form with height and weight inputs
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Height Input
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Height (m)',
                          hintText: 'e.g., 1.75',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                            horizontal: screenWidth * 0.04,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _height = double.parse(value ?? '0');
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Weight Input
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          hintText: 'e.g., 65',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                            horizontal: screenWidth * 0.04,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _weight = double.parse(value ?? '0');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Floating Action Button for BMI Calculation
                FloatingActionButton.extended(
                  onPressed: _calculateBMI,
                  label: Text('Calculate BMI'),
                  icon: Icon(Icons.calculate),
                  backgroundColor: Colors.blueAccent,
                ),
                SizedBox(height: screenHeight * 0.05),

                // BMI Results Section
                if (_bmi > 0)
                  Column(
                    children: [
                      // Animated Circular Progress Indicator
                      SizedBox(
                        height: screenHeight * 0.2,
                        width: screenHeight * 0.2,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: (_bmi / 40).clamp(0.0, 1.0),
                              strokeWidth: 10,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blueAccent,
                            ),
                            Center(
                              child: Text(
                                _bmi.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: screenHeight * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        "Category: $_category",
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Message Box
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          _message,
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
