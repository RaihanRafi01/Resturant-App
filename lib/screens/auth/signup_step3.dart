import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/signup_step4.dart';

class SignUpStep3Screen extends StatefulWidget {
  const SignUpStep3Screen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpStep3Screen();
}

class _SignUpStep3Screen extends State<SignUpStep3Screen> {
  int? _selectedPriceRange;
  int? _selectedCuisine;
  TextEditingController _otherCuisineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 3'), centerTitle: true),
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
                  'Dining Preferences',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tell us more about your dining preferences to help us personalize your experience.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                _buildSectionTitle('Preferred Price Range:'),
                _buildRadioList(['£5', '£50', '£100', '£1000'], _selectedPriceRange, (int? val) {
                  setState(() => _selectedPriceRange = val);
                }),
                _buildSectionTitle('What type of cuisine do you prefer?'),
                _buildCuisineRadioList(),
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

  Widget _buildCuisineRadioList() {
    return Column(
      children: [
        _buildRadioList(
          ['Italian', 'Chinese', 'Japanese', 'Mediterranean', 'French', 'American', 'Thai', 'Spanish'],
          _selectedCuisine,
              (int? val) {
            setState(() => _selectedCuisine = val);
          },
        ),
        ListTile(
          visualDensity: VisualDensity.compact,
          title: const Text('Other (please specify)'),
          leading: Radio<int?>(
            value: 9,
            groupValue: _selectedCuisine,
            activeColor: const Color(0xFFEA5326),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (int? val) {
              setState(() {
                _selectedCuisine = val;
              });
            },
          ),
        ),
        if (_selectedCuisine == 9)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              controller: _otherCuisineController,
              decoration: const InputDecoration(
                labelText: 'Please specify',
                border: OutlineInputBorder(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpStep4Screen(),
            ),
          );
          if (_selectedCuisine == 9) {
            print("User specified cuisine: ${_otherCuisineController.text}");
          }
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
    _otherCuisineController.dispose();
    super.dispose();
  }
}
