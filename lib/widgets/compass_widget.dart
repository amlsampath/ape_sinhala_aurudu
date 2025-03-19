import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double? _heading = 0; // Initial heading value

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        _heading = event.heading;
      });
    });
  }

  // 🔹 Get Direction from Heading (Sinhala Labels)
  String _getDirectionFromHeading(double heading) {
    if (heading >= 337.5 || heading < 22.5) {
      return "උතුර (North)";
    } else if (heading >= 22.5 && heading < 67.5) {
      return "උතුරු නැගෙනහිර (Northeast)";
    } else if (heading >= 67.5 && heading < 112.5) {
      return "නැගෙනහිර (East)";
    } else if (heading >= 112.5 && heading < 157.5) {
      return "දකුණු නැගෙනහිර (Southeast)";
    } else if (heading >= 157.5 && heading < 202.5) {
      return "දකුණ (South)";
    } else if (heading >= 202.5 && heading < 247.5) {
      return "දකුණු බටහිර (Southwest)";
    } else if (heading >= 247.5 && heading < 292.5) {
      return "බටහිර (West)";
    } else {
      return "උතුරු බටහිර (Northwest)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(127, 250, 218, 122),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Transform.rotate(
              angle:
                  ((_heading ?? 0) *
                      (math.pi / 180) *
                      -1), // Convert to radians
              child: Image.asset(
                'assets/compass.png', // 📌 Compass Image
                width: 300,
                height: 300,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _heading.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            _getDirectionFromHeading(_heading ?? 0),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
