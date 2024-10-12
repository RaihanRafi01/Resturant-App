import 'package:flutter/material.dart';
import 'package:restaurant_raihan/screens/auth/signup_step3.dart';

class SignUpStep2Screen extends StatefulWidget {
  const SignUpStep2Screen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpStep2Screen();
}

class _SignUpStep2Screen extends State<SignUpStep2Screen> {
  final List<TextEditingController> occasionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> dateControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  Future<void> _selectDate(BuildContext context, int index) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dateControllers[index].text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Widget _buildOccasionField(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Occasion ${index + 1}'),
        const SizedBox(height: 5),
        TextField(
          controller: occasionControllers[index],
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text('Date'),
        const SizedBox(height: 5),
        TextField(
          controller: dateControllers[index],
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () => _selectDate(context, index),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 2'), centerTitle: true),
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Do you have any special occasions you\'d like us to remind you about?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < 3; i++) _buildOccasionField(i),
                const SizedBox(height: 60),
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
                      const Color.fromRGBO(255, 131, 51, 1),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in occasionControllers) {
      controller.dispose();
    }
    for (var controller in dateControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
