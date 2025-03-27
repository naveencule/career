import 'package:flutter/material.dart';
import 'package:career_guidance/ip.dart';

void main() {
  runApp(const CareerGuidance());
}

class CareerGuidance extends StatefulWidget {
  const CareerGuidance({super.key});

  @override
  State<CareerGuidance> createState() => CareerGuidanceState();
}

class CareerGuidanceState extends State<CareerGuidance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const ipset(),
    );
  }
}
 