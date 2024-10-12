import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/signup_step3.dart';

class SignUpStep2Screen extends StatefulWidget {
  const SignUpStep2Screen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpStep2Screen();
}

class _SignUpStep2Screen extends State<SignUpStep2Screen> {
  final TextEditingController occasionController1 = TextEditingController();
  final TextEditingController occasionController2 = TextEditingController();
  final TextEditingController occasionController3 = TextEditingController();

  Future<void> _selectDate(BuildContext context, int occasion) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        if (occasion == 1) {
          occasionController1.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
        if (occasion == 2) {
          occasionController2.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
        if (occasion == 3) {
          occasionController3.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 2'),
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
                    'Do you have any special occasions you\'d like us to remind you about?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text('Occasion 1'),
                  const SizedBox(height: 5),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Date'),
                  const SizedBox(height: 5),
                  TextField(
                    controller: occasionController1,
                    readOnly: true, // Prevents manual editing
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, 1);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Occasion 2'),
                  const SizedBox(height: 5),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Date'),
                  const SizedBox(height: 5),
                  TextField(
                    controller: occasionController2,
                    readOnly: true, // Prevents manual editing
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, 2);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Occasion 3'),
                  const SizedBox(height: 5),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Date'),
                  const SizedBox(height: 5),
                  TextField(
                    controller: occasionController3,
                    readOnly: true, // Prevents manual editing
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)), // Rounded corners
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, 3);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 60), // Add extra space before the button
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
                        backgroundColor:
                        const Color.fromRGBO(255, 131, 51, 1), // Set login button color
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
