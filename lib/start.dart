import 'package:flutter/material.dart';
import 'package:random/myapp.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final TextEditingController _nameController = TextEditingController();

  void start() {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InputPage(userName: name), // Passing the name
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid name!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello User!!"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        color: const Color.fromARGB(255, 228, 234, 234),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/pic.png',
                height: 400,
                width: 350,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFDBE5F1),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: start,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent, // Background color
                  foregroundColor: Colors.black, // Text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'let\'s start',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward), // Add an arrow icon
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
