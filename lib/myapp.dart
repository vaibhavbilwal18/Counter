import 'package:flutter/material.dart';
import 'package:random/result_page.dart';

class InputPage extends StatefulWidget {
  final String userName;
  const InputPage({super.key, required this.userName});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _selectedWeightUnit = 'kg'; // Initially kg is selected
  String _selectedHeightUnit = 'cm'; // Initially cm is selected

  void calculateBMI() {
    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      // Convert weight to kg if in lbs
      if (_selectedWeightUnit == 'lbs') {
        weight = weight / 2.20462; // Convert lbs to kg
      }

      // Convert height to cm if in inches or feet
      if (_selectedHeightUnit == 'inch') {
        height = height * 2.54; // Convert inches to cm
      } else if (_selectedHeightUnit == 'ft') {
        height = height * 30.48; // Convert feet to cm
      }

      double bmi = weight / ((height / 100) * (height / 100));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(bmiResult: bmi),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.userName}"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Row for gender selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Male Image
                ClipOval(
                  child: Image.asset(
                    'assets/male.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                // Female Image
                ClipOval(
                  child: Image.asset(
                    'assets/female.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            // Gender toggle buttons
            SizedBox(
              child: ToggleButtons(
                isSelected: [true, false], // Set male as default
                onPressed: (int newIndex) {},
                children: [
                  SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Male',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Female',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ],
                fillColor: Colors.lightBlueAccent,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            //const SizedBox(height: 20),
            // Age input field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your age',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 20), // Added spacing between fields
            // Weight input and unit dropdown
            Row(
              children: [
                // Weight input field
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your weight',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                // Weight unit dropdown
                DropdownButton<String>(
                  value: _selectedWeightUnit,
                  items: <String>['kg', 'lbs']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedWeightUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            //const SizedBox(height: 20), // Added spacing between fields
            // Height input and unit dropdown
            Row(
              children: [
                // Height input field
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your height',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                // Height unit dropdown
                DropdownButton<String>(
                  value: _selectedHeightUnit,
                  items: <String>['cm', 'inch', 'ft']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedHeightUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            //const SizedBox(height: 20), // Added spacing between fields
            // Calculate BMI button
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent, // Background color
                foregroundColor: Colors.black, // Text color
                side: BorderSide(
                    color: Colors.grey, width: 0.2), // Border color and width
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
