import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/signup_data.dart';
import 'package:restaurant_raihan/screens/auth/signup_summary.dart';

class SignUpStep4Screen extends StatefulWidget {
  final SignUpData signUpData;

  const SignUpStep4Screen({super.key, required this.signUpData});

  @override
  State<StatefulWidget> createState() => _SignUpStep4Screen();
}

class _SignUpStep4Screen extends State<SignUpStep4Screen> {
  int? _selectedNewsletter;
  int? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 4'), centerTitle: true),
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
                  'Subscription Preferences',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Stay updated with the latest news, events, and special offers from Urban Foodie.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                _buildSectionTitle('Subscribe to our Newsletter'),
                _buildRadioList(
                  ['Yes, I want to receive the newsletter and updates'],
                  _selectedNewsletter,
                      (int? val) {
                    setState(() {
                      _selectedNewsletter = val;
                      widget.signUpData.newsletterSubscription = val == 1; // Update the signUpData
                    });
                  },
                ),
                _buildSectionTitle('Preferred Communication Method'),
                _buildRadioList(
                  ['Email', 'SMS', 'Push Notification'],
                  _selectedMethod,
                      (int? val) {
                    setState(() {
                      _selectedMethod = val;
                      widget.signUpData.preferredCommunicationMethod = val; // Update the signUpData
                    });
                  },
                ),
                const SizedBox(height: 60),
                _buildNextButton(context),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildRadioList(List<String> options, int? selectedValue, ValueChanged<int?> onChanged) {
    return Column(
      children: List.generate(options.length, (index) {
        return ListTile(
          visualDensity: VisualDensity.compact, // Reduce vertical/horizontal spacing
          title: Text(options[index]),
          leading: Radio<int?>(
            value: index + 1,
            groupValue: selectedValue,
            activeColor: const Color(0xFFEA5326),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce the size of the tap target
            onChanged: onChanged,
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Ensure the last selected values are saved
          if (_selectedNewsletter != null) {
            widget.signUpData.newsletterSubscription = _selectedNewsletter == 1;
          }
          if (_selectedMethod != null) {
            widget.signUpData.preferredCommunicationMethod = _selectedMethod;
          }

          // Navigate to the Summary screen and pass signUpData
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryScreen(signUpData: widget.signUpData),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 131, 51, 1),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Next', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
