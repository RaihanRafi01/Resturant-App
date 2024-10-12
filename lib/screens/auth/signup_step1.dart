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
  String userType = 'User';
  String selectedGender = 'Male';
  bool passwordVisible = false, confirmPasswordVisible = false;
  XFile? _pickedImage;
  final TextEditingController dobController = TextEditingController();

  Future<void> _selectDate() async {
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Widget _buildTextField({String? label, bool isPassword = false, TextEditingController? controller, IconData? icon, bool readOnly = false, void Function()? onIconPress}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ''),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPassword && !passwordVisible,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: icon != null ? Icon(icon) : null,
            suffixIcon: isPassword ? IconButton(
              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: onIconPress,
            ) : null,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRadioButton(String value, String title) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(title),
        value: value,
        groupValue: userType,
        activeColor: Colors.green,
        onChanged: (value) {
          setState(() {
            userType = value!;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), centerTitle: true),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/images/auth_back.png'),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _pickedImage != null
                                ? FileImage(File(_pickedImage!.path))
                                : const AssetImage('assets/images/profile_avatar.png') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0, right: 0,
                            child: InkWell(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.asset('assets/images/camera_logo.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildRadioButton('User', 'User'),
                            _buildRadioButton('Vendor', 'Vendor'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Full Name'),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: _buildTextField(label: '', controller: TextEditingController())),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField(label: '', controller: TextEditingController())),
                  ],
                ),
                _buildTextField(label: 'Email', icon: Icons.email),
                _buildTextField(label: 'Location', icon: Icons.location_on),
                _buildTextField(label: 'Password', isPassword: true, onIconPress: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                }),
                _buildTextField(label: 'Confirm Password', isPassword: true, onIconPress: () {
                  setState(() {
                    confirmPasswordVisible = !confirmPasswordVisible;
                  });
                }),
                _buildTextField(
                  label: 'Date of Birth',
                  controller: dobController,
                  icon: Icons.date_range,
                  readOnly: true,
                  onIconPress: _selectDate,
                ),
                const Text('Contact'),
                const SizedBox(height: 5),
                IntlPhoneField(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  initialCountryCode: 'BD',
                  onChanged: (phone) => print(phone.completeNumber),
                ),
                const SizedBox(height: 10),
                const Text('Gender'),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) => setState(() => selectedGender = value!),
                  decoration: const InputDecoration(border: OutlineInputBorder(), prefixIcon: Icon(Icons.person_outline)),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpStep2Screen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 131, 51, 1),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDividerWithText('or continue with'),
                _buildGoogleButton(),
                const SizedBox(height: 20),
                _buildLoginText(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(text),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {}, // Add Google sign-in logic here
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset('assets/images/google_icon.png', height: 24),
              ),
            ),
            const Text('Continue with Google', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginText() {
    return Center(
      child: GestureDetector(
        onTap: () {}, // Handle navigation to login
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
    );
  }
}
