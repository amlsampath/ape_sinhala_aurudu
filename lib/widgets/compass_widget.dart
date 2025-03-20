import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double? _heading = 0;
  bool _hasCompass = false;
  String _debugInfo = '';
  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void initState() {
    super.initState();
    _initCompass();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  void _initCompass() async {
    try {
      bool? hasCompass = await FlutterCompass.events?.isEmpty;

      if (mounted) {
        setState(() {
          _hasCompass = hasCompass == false; // if events stream is not empty
          _debugInfo =
              'Compass Status: ${_hasCompass ? 'Available' : 'Not Available'}';
        });
      }

      if (_hasCompass) {
        _compassSubscription = FlutterCompass.events!.listen(
          (event) {
            if (mounted && event.heading != null) {
              setState(() {
                _heading = event.heading;
                _debugInfo = 'Heading: ${_heading?.toStringAsFixed(1)}°';
              });
            }
          },
          onError: (e) {
            setState(() {
              _debugInfo = 'Error: $e';
              _hasCompass = false;
            });
          },
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _debugInfo = 'Init Error: $e';
          _hasCompass = false;
        });
      }
    }
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
              angle: ((_heading ?? 0) * (math.pi / 180) * -1),
              child: Image.asset('assets/compass.png', width: 300, height: 300),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${_heading?.toStringAsFixed(1) ?? '0.0'}°',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            _getDirectionFromHeading(_heading ?? 0),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (!_hasCompass) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  const Text(
                    'Compass sensor not found on this device',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (_debugInfo.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      _debugInfo,
                      style: TextStyle(
                        color: Colors.red.withOpacity(0.7),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
