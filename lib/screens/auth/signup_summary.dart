import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/signup_data.dart';

class SummaryScreen extends StatelessWidget {
  final SignUpData signUpData;

  const SummaryScreen({
    super.key,
    required this.signUpData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary'), centerTitle: true),
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
                const Text(
                  'Please review your information:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                _buildSummaryItem('Full Name:', '${signUpData.fullName1} ' ' ${signUpData.fullName2}'),
                _buildSummaryItem('Email:', signUpData.email),
                _buildSummaryItem('Location:', signUpData.location),
                _buildSummaryItem('User Type:', signUpData.userType),
                _buildSummaryItem('Gender:', signUpData.gender),
                _buildSummaryItem('Contact:', signUpData.phoneNumber),
                const SizedBox(height: 20),
                const Text('Special Occasions:', style: TextStyle(fontWeight: FontWeight.w600)),
                for (int i = 0; i < signUpData.occasionList!.length; i++)
                  _buildSummaryItem('Occasion ${i + 1}:', signUpData.occasionList![i]),
                for (int i = 0; i < signUpData.dateList!.length; i++)
                  _buildSummaryItem('Date ${i + 1}:', signUpData.dateList![i]),
                const SizedBox(height: 20),
                _buildSummaryItem('Preferred Price Range:', getPriceRange(signUpData.preferredPriceRange!)),
                _buildSummaryItem('Cuisine Preference:', signUpData.cuisinePreference!,),
                _buildSummaryItem('Newsletter Subscription:', signUpData.newsletterSubscription! ? 'Yes' : 'No'),
                _buildSummaryItem('Preferred Communication Method:', getMethod(signUpData.preferredCommunicationMethod!)),
                const SizedBox(height: 60),
                _buildSubmitButton(context),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$title $content',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle final submission or navigation
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 131, 51, 1),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  String getPriceRange(int selectedRange) {
    switch (selectedRange) {
      case 1:
        return '£5';
      case 2:
        return '£50';
      case 3:
        return '£100';
      case 4:
        return '£1000';
      default:
        return 'Not specified';
    }
  }

  /*String getCuisine(String selectedCuisine, String other) {
    switch (selectedCuisine) {
      case 'Italian':
        return 'Italian';
      case 'Chinese':
        return 'Chinese';
      case 'Japanese':
        return 'Japanese';
      case 'Mediterranean':
        return 'Mediterranean';
      case 5:
        return 'French';
      case 6:
        return 'American';
      case 7:
        return 'Thai';
      case 8:
        return 'Spanish';
      case 9:
        return other;
      default:
        return 'Not specified';
    }
  }*/

  String getMethod(int selectedMethod) {
    switch (selectedMethod) {
      case 1:
        return 'Email';
      case 2:
        return 'SMS';
      case 3:
        return 'Push Notification';
      default:
        return 'Not specified';
    }
  }
}
