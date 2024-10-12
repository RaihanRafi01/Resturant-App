import 'package:flutter/material.dart';

class SignUpStep3Screen extends StatefulWidget {
  const SignUpStep3Screen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpStep3Screen();
}

class _SignUpStep3Screen extends State<SignUpStep3Screen> {
  int? _selectedOption1; // To store the selected option for the first question
  int? _selectedOption2; // To store the selected option for the second question

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 3'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.1, // Set opacity for the background image
              child: Image.asset(
                'assets/images/auth_back.png', // Path to your background image
              ),
            ),
          ),
          SingleChildScrollView( // Wrap the content in a scrollable view
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dining Preferences',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                const Text(
                  'Tell us more about your dining preferences to help us personalize your experience.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),

                  // First Radio Button Question
                  const Text(
                    'Preferred Price Range:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  ListTile(
                    title: const Text('£5'),
                    leading: Radio<int>(
                      value: 1,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption1,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption1 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('£50'),
                    leading: Radio<int>(
                      value: 2,
                      groupValue: _selectedOption1,
                      activeColor: const Color(0xFFEA5326),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption1 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('£100'),
                    leading: Radio<int>(
                      value: 3,
                      groupValue: _selectedOption1,
                      activeColor: const Color(0xFFEA5326),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption1 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('£1000'),
                    leading: Radio<int>(
                      value: 4,
                      groupValue: _selectedOption1,
                      activeColor: const Color(0xFFEA5326),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption1 = value;
                        });
                      },
                    ),
                  ),
                  // Second Radio Button Question
                  const Text(
                    'What type of cuisine do you prefer?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  ListTile(
                    title: const Text('Italian'),
                    leading: Radio<int>(
                      value: 1,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Chinese'),
                    leading: Radio<int>(
                      value: 2,
                      groupValue: _selectedOption2,
                      activeColor: const Color(0xFFEA5326),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Japanese'),
                    leading: Radio<int>(
                      value: 3,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Mediterranean'),
                    leading: Radio<int>(
                      value: 4,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('French'),
                    leading: Radio<int>(
                      value: 5,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('American'),
                    leading: Radio<int>(
                      value: 6,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Thai'),
                    leading: Radio<int>(
                      value: 7,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Spanish'),
                    leading: Radio<int>(
                      value: 8,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Other (Specify): _________'),
                    leading: Radio<int>(
                      value: 9,
                      activeColor: const Color(0xFFEA5326),
                      groupValue: _selectedOption2,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  ),


                  const SizedBox(height: 60), // Add extra space before the button

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpStep3Screen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 131, 51, 1), // Set login button color
                        padding: const EdgeInsets.symmetric(vertical: 15), // Vertical padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60), // Optional: extra space after button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
