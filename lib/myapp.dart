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

  List<bool> _isSelected = [true, false]; // Initially male is selected

  void calculateBMI() {
    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
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
        title: Text("Hi ${widget.userName}"), // Correct interpolation
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
                    'assets/male.png', // Replace with your male image asset
                    width: 150,
                    height: 150,
                    //color: _isSelected[0]
                    //   ? null
                    //  : Colors.grey, // Grey out if not selected
                  ),
                ),
                // Female Image
                ClipOval(
                  child: Image.asset(
                    'assets/female.png', // Replace with your female image asset
                    width: 150,
                    height: 150,
                    //color: _isSelected[1]
                    //    ? null
                    //    : Colors.grey, // Grey out if not selected
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 20),
            // Gender toggle buttons
            SizedBox(
              child: ToggleButtons(
                isSelected: _isSelected,
                onPressed: (int newIndex) {
                  setState(() {
                    for (int index = 0; index < _isSelected.length; index++) {
                      _isSelected[index] = index == newIndex;
                    }
                  });
                },
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
                selectedColor: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            //const SizedBox(height: 20),
            // Age input
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Enter your age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            //const SizedBox(height: 20),
            // Weight input
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Enter your weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            // const SizedBox(height: 20),
            // Height input
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Enter your height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            //const SizedBox(height: 20),
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
