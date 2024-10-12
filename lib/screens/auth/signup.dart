import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:restaurant_raihan/screens/auth/signup_step2.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String userType = 'User'; // Default value for radio button
  String selectedGender = 'Male'; // Default value for gender dropdown
  final TextEditingController dobController = TextEditingController();
  bool passwordVisible = false; // Track visibility of password
  bool confirmPasswordVisible = false; // Track visibility of confirm password
  XFile? _pickedImage; // Store picked image for profile picture

  // Function to show the DatePicker and set the selected date
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  // Function to pick an image for profile avatar
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image with opacity
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.1, // Set opacity for the background image
              child: Image.asset(
                'assets/images/auth_back.png', // Path to your background image
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0), // Add padding to the whole screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile picture and user type (User/Vendor) radio buttons
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _pickedImage != null
                                  ? FileImage(File(_pickedImage!.path)) // Show picked image
                                  : const AssetImage('assets/images/profile_avatar.png') as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: _pickImage, // Your function to pick an image
                                child: Container(
                                  width: 40, // Set the width for the circle
                                  height: 40, // Set the height for the circle
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white, // Optional background color if needed
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/camera_logo.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('User'),
                                  value: 'User',
                                  groupValue: userType,
                                  activeColor: Colors.green, // Set the color to green
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Vendor'),
                                  value: 'Vendor',
                                  groupValue: userType,
                                  activeColor: Colors.green, // Set the color to green
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Full name text fields (First and Last name)
                  const Text('Full Name'),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Email input field
                  const Text('Email'),
                  const SizedBox(height: 5),
                  const TextField(
                    keyboardType: TextInputType.emailAddress, // Set keyboard type for email
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Contact number with country code and flag
                  const Text('Contact'),
                  const SizedBox(height: 5),
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    initialCountryCode: 'BD', // Set default country
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  const SizedBox(height: 10),

                  // Location input field
                  const Text('Location'),
                  const SizedBox(height: 5),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Gender dropdown menu
                  const Text('Gender'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Date of Birth picker
                  const Text('Date of Birth'),
                  const SizedBox(height: 5),
                  TextField(
                    controller: dobController,
                    readOnly: true, // Prevents manual editing
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password input field
                  const Text('Password'),
                  const SizedBox(height: 5),
                  TextField(
                    obscureText: !passwordVisible, // Hide or show password
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Confirm Password input field
                  const Text('Confirm Password'),
                  const SizedBox(height: 5),
                  TextField(
                    obscureText: !confirmPasswordVisible, // Hide or show confirm password
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpStep2Screen()),
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
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Divider with "or continue with" text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("or continue with"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Continue with Google button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle Google sign-in logic
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15), // Add vertical padding for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Set the border radius to 8
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center, // Ensures the text is centered
                        children: [
                          // Left-aligned icon
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16), // Add left padding for the icon
                              child: Image.asset(
                                'assets/images/google_icon.png',
                                height: 24,
                              ),
                            ),
                          ),
                          // Centered text
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 16, // Set text size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account? Log in
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Handle navigation to login screen
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
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
