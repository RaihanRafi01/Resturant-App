import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/onboarding/obboarding_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // This makes the image fill the whole screen
        children: [
          // Background image with opacity
          Opacity(
            opacity: 0.07, // Adjust opacity as needed
            child: Image.asset(
              'assets/images/onbording_background.png', // Background image
              fit: BoxFit.cover,
            ),
          ),
          // Center image (Optional, adjust as needed)
          Center(
            child: Image.asset(
              'assets/images/startpage_intro.png', // Intro image
              fit: BoxFit.cover,
            ),
          ),
          // Positioned text and button at the bottom
          Positioned(
            bottom: 40, // Adjust as needed
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Custom Text
                const Padding(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Text(
                    'Urban Foodie comes to help with your hunger problem by easily finding any restaurant.',
                    textAlign: TextAlign.center,  // Center-aligns the text
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black, // Adjust text color
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Custom Button with Image
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/btn_arrow.png', // Intro image
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
