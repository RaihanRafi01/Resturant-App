import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/signup_step1.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Make sure the stack fills the screen
        children: [
          // Background image positioned at the bottom with opacity
          Positioned(
            bottom: 0,  // Anchors the image at the bottom
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1, // Adjust opacity as needed
              child: Image.asset(
                'assets/images/auth_back.png', // Replace with your background image path
                fit: BoxFit.cover, // Ensure the image stretches horizontally
              ),
            ),
          ),
          // Foreground content positioned with fixed width and height
           // Positioned from the left
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
                width: 357,
                height: 378,// Fixed height
                child: Column( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Intro image
                    SizedBox(
                      width: 275,
                      height: 164,
                      child: Image.asset(
                        'assets/images/appname.png',
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'Let’s get started!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Login to Stay healthy and fit',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Gap of 20px between the image and buttons
                    // Login Button with fixed width
                    SizedBox(
                      width: 317,
                      height: 54,// Set fixed width for the button
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to login screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 131, 51, 1), // Set login button color
                          padding: EdgeInsets.symmetric(vertical: 15), // Vertical padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Space between buttons
                    // Registration Button with fixed width
                    SizedBox(
                      width: 317,
                      height: 54,// Set fixed width for the button
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Button background color
                          padding: EdgeInsets.symmetric(vertical: 15), // Vertical padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                            side: BorderSide(
                              color: Color.fromRGBO(255, 131, 51, 1), // Orange border color
                              width: 1, // Border width (adjust as needed)
                            ),
                          ),
                        ),
                        child: const Text(
                          'Sign UP',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 131, 51, 1), // Orange text color
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),

        ],
      ),
    );
  }
}
