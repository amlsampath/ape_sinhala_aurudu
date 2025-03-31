import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ape_sinhala_aurudu/pages/home_screen.dart';
import 'package:sinhala_unicode_converter/sinhala_unicode_converter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              Image.asset('assets/sun.png', height: size.height * .22),
              Positioned(
                top: 100,
                left: 40,
                child: Image.asset('assets/sky.png', width: size.width * .2),
              ),
              Positioned(
                top: 100,
                right: 60,
                child: Image.asset('assets/sky2.png'),
              ),
              Positioned(
                top: 100,
                left: 80,
                child: Image.asset('assets/style1.png'),
              ),
            ],
          ),
          SizedBox(height: 40),
          Image.asset('assets/logo.png', height: size.height * .2),
          SizedBox(height: 20),
          Text(
            SinhalaUnicode.sinhalaToUnicode(
              "ඔබටත් ඔබගේ පවුලේ සැමටත් සුභම සුභ\nඅවුරුද්දක් වේවා",
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontFamily: 'FMEmaneex',
            ),
          ),
          SizedBox(height: size.height * .15),
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
              SinhalaUnicode.sinhalaToUnicode("පිවිසෙන්න"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'FMEmaneex',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
