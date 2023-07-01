import 'package:flutter/material.dart';
import 'package:weather_app/app/screen/display.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: display(),
      
    );
  }
}
