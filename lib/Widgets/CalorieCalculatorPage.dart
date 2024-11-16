import 'package:flutter/material.dart';

class CalorieCalculatorPage extends StatefulWidget {
  @override
  _CalorieCalculatorPageState createState() => _CalorieCalculatorPageState();
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  double weight = 0;
  double height = 0;
  int age = 0;
  String gender = 'Male';
  String activityLevel = 'Sedentary';
  double calorieIntake = 0;

  void calculateCalories() {
    double bmr = (gender == 'Male')
        ? (10 * weight + 6.25 * height - 5 * age + 5)
        : (10 * weight + 6.25 * height - 5 * age - 161);

    double activityFactor = {
      'Sedentary': 1.2,
      'Lightly Active': 1.375,
      'Moderately Active': 1.55,
      'Very Active': 1.725
    }[activityLevel]!;

    setState(() {
      calorieIntake = bmr * activityFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Calorie Calculator"),
        backgroundColor: Color(0xFF6A1B9A),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAB47BC), Color(0xFFF8BBD0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Calculate Your Daily Calorie Needs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField("Weight (kg)", "Enter weight", Icons.fitness_center),
                  SizedBox(height: screenHeight * 0.02),
                  _buildInputField("Height (cm)", "Enter height", Icons.height),
                  SizedBox(height: screenHeight * 0.02),
                  _buildInputField("Age", "Enter age", Icons.cake),
                  SizedBox(height: screenHeight * 0.02),

                  _buildDropdownField("Gender", gender, ['Male', 'Female']),
                  SizedBox(height: screenHeight * 0.02),

                  _buildDropdownField(
                    "Activity Level",
                    activityLevel,
                    ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active'],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        calculateCalories();
                      }
                    },
                    child: Text("Calculate"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6A1B9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(screenWidth * 0.6, 50),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  if (calorieIntake > 0) _buildResultCard(screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, IconData icon) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF6A1B9A)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (value) {
        switch (label) {
          case 'Weight (kg)':
            weight = double.tryParse(value) ?? 0;
            break;
          case 'Height (cm)':
            height = double.tryParse(value) ?? 0;
            break;
          case 'Age':
            age = int.tryParse(value) ?? 0;
            break;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) {
          return 'Please enter a valid $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() {
          switch (label) {
            case 'Gender':
              gender = newValue!;
              break;
            case 'Activity Level':
              activityLevel = newValue!;
              break;
          }
        });
      },
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildResultCard(double screenHeight) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Your Daily Calorie Requirement",
              style: TextStyle(
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "${calorieIntake.toStringAsFixed(2)} kcal",
              style: TextStyle(
                fontSize: screenHeight * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Stay active and maintain a balanced diet!",
              style: TextStyle(
                color: Colors.white70,
                fontSize: screenHeight * 0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
