import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('Last Updated: 05/31/26'),
              SizedBox(height: 16),
              Text(
                'Welcome to Logixplore. By using this App, you agree to be bound by these Terms & Conditions. '
                'LogicGates is provided for educational purposes and offers handouts, logic gate simulators, generated '
                'questions, and learning tools.',
                style: TextStyle(height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'By using Logixplore, you agree to follow these Terms & Conditions.',
              ),
              SizedBox(height: 8),
              Text(
                '2. Educational Purpose',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Logixplore is intended solely for educational use to help users learn logic gates.',
              ),
              SizedBox(height: 8),
              Text(
                '3. User Responsibility',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Users must use the system properly and avoid any misuse of its features.',
              ),
              SizedBox(height: 8),
              Text(
                '4. System Content and Accuracy',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'All outputs and simulations are for learning purposes only and may not always be perfectly accurate.',
              ),
              SizedBox(height: 8),
              Text(
                '5. Intellectual Property',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'All system content and design of Logixplore belong to the developers and may not be copied or reused without permission.',
              ),
              SizedBox(height: 8),
              Text(
                '6. Data and Privacy',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Any collected data is used only to improve system performance and learning experience.',
              ),
              SizedBox(height: 8),
              Text(
                '7. System Updates and Improvements',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'The developers may update or modify the system at any time to improve functionality.',
              ),
              SizedBox(height: 8),
              Text('8. Contact', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'For any inquiries or support, please contact us at logixplore00@gmail.com.',
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
