import 'package:flutter/material.dart';

class WaterIntakeCalculatorPage extends StatefulWidget {
  @override
  _WaterIntakeCalculatorPageState createState() => _WaterIntakeCalculatorPageState();
}

class _WaterIntakeCalculatorPageState extends State<WaterIntakeCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  double weight = 0;
  int age = 18;
  double waterIntake = 0;

  // Function to calculate water intake based on weight
  void calculateWaterIntake() {
    setState(() {
      waterIntake = weight * 30; // 30 ml per kg body weight
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Water Intake Calculator"),
        backgroundColor: Color(0xFF004D40),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)]
            ,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: ListView(
          children: [
            Text(
              "Calculate your recommended daily water intake",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Weight Input
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.fitness_center, color: Color(0xFF004D40)),
                      labelText: "Weight (kg)",
                      labelStyle: TextStyle(color: Color(0xFF004D40)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        weight = double.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || double.tryParse(value) == null) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Age Slider
                  Text(
                    "Age: $age years",
                    style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.02),
                  ),
                  Slider(
                    value: age.toDouble(),
                    min: 10,
                    max: 100,
                    divisions: 90,
                    label: age.toString(),
                    activeColor: Color(0xFF004D40),
                    inactiveColor: Colors.white60,
                    onChanged: (value) {
                      setState(() {
                        age = value.toInt();
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Calculate Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        calculateWaterIntake();
                      }
                    },
                    child: Text("Calculate Water Intake"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004D40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(screenWidth * 0.6, 50),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Display Result
                  if (waterIntake > 0)
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Your Recommended Daily Water Intake",
                            style: TextStyle(
                              fontSize: screenHeight * 0.025,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "${waterIntake.toStringAsFixed(2)} ml",
                            style: TextStyle(
                              fontSize: screenHeight * 0.04,
                              color: Color(0xFF004D40),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Remember to drink more during physical activity or hot weather!",
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              color: Colors.teal[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
