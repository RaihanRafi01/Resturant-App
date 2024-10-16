import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/auth_landing.dart';
import 'package:restaurant_raihan/screens/onboarding/obboarding_screen.dart';
import 'package:restaurant_raihan/screens/onboarding/start_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthLandingScreen(), // Home screen where the button is
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the notification screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthLandingScreen()),
                );
              },
              child: Text('Go to AR Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
