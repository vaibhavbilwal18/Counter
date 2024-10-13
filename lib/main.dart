import 'package:flutter/material.dart';
import 'package:random/start.dart';

//import 'start.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
