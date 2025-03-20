import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ape_sinhala_aurudu/pages/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#f0cc62'),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(),
              Image.asset('assets/sun.png'),
              Positioned(
                top: 100,
                left: 20,
                child: Image.asset('assets/sky.png'),
              ),
              Positioned(
                top: 160,
                right: 40,
                child: Image.asset('assets/sky2.png'),
              ),
              Positioned(
                top: 160,
                left: 50,
                child: Image.asset('assets/style1.png'),
              ),
            ],
          ),
          SizedBox(height: 40),
          Image.asset('assets/logo.png'),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              // Save that user has seen welcome screen
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('hasSeenWelcome', true);

              // Navigate to home screen and remove welcome screen from stack
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor('#443627'),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
