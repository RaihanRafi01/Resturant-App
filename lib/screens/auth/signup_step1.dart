import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_raihan/screens/auth/signup_data.dart';
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

  // Create an instance of SignUpData
  final SignUpData signUpData = SignUpData(
    fullName1: '',
    fullName2: '',
    userType: '',
    email: '',
    location: '',
    password: '',
    confirmPassword: '',
    dob: '',
    phoneNumber: '',
    gender: '',
    occasionList: [],
    dateList: [],
    preferredPriceRange: null,
    cuisinePreference: '',
    newsletterSubscription: null,
    preferredCommunicationMethod: null,
  );
  final TextEditingController dobController = TextEditingController();
  final TextEditingController fullNameController1 = TextEditingController();
  final TextEditingController fullNameController2 = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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

  Widget _buildTextField({
    required String label,
    bool isPassword = false,
    required TextEditingController controller,
    IconData? icon,
    bool readOnly = false,
    void Function()? onIconPress,
    bool isConfirmPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPassword
              ? (isConfirmPassword
              ? !confirmPasswordVisible
              : !passwordVisible)
              : false,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isConfirmPassword
                    ? (confirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off)
                    : (passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              onPressed: onIconPress,
            )
                : (icon == Icons.date_range
                ? IconButton(
              icon: Icon(icon),
              onPressed: onIconPress,
            )
                : null),
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
                            bottom: 0,
                            right: 0,
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
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'First name',
                        controller: fullNameController1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        label: 'Last name',
                        controller: fullNameController2,
                      ),
                    ),
                  ],
                ),

                _buildTextField(label: 'Email', controller: emailController, icon: Icons.email),
                _buildTextField(label: 'Location', controller: locationController, icon: Icons.location_on),

                _buildTextField(
                  label: 'Password',
                  isPassword: true,
                  controller: passwordController,
                  onIconPress: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                _buildTextField(
                  label: 'Confirm Password',
                  isPassword: true,
                  isConfirmPassword: true,
                  controller: confirmPasswordController,
                  onIconPress: () {
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                ),
                _buildTextField(
                  label: 'Date of Birth',
                  controller: dobController,
                  readOnly: true,
                  icon: Icons.date_range,
                  onIconPress: _selectDate,
                ),
                const Text('Contact'),
                const SizedBox(height: 5),
                IntlPhoneField(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  initialCountryCode: 'BD',
                  onChanged: (phone) {
                    signUpData.phoneNumber = phone.completeNumber;
                  },
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
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                      signUpData.gender = selectedGender;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      signUpData.fullName1 = fullNameController1.text;
                      signUpData.fullName2 = fullNameController2.text;
                      signUpData.userType = userType;
                      signUpData.email = emailController.text;
                      signUpData.location = locationController.text;
                      signUpData.password = passwordController.text;
                      signUpData.confirmPassword = confirmPasswordController.text;
                      signUpData.dob = dobController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpStep2Screen(signUpData: signUpData),
                        ),
                      );
                    },
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
                const SizedBox(height: 20),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Image.asset('assets/images/google_icon.png', height: 24),
        label: const Text('Sign Up with Google', style: TextStyle(fontSize: 16, color: Colors.black)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {},
          child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
