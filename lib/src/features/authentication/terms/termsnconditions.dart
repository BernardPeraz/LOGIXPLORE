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
              Text('Last Updated: 11/11/25'),
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
                'Your continued use constitutes acceptance of any updates to these Terms.',
              ),
              SizedBox(height: 8),
              Text(
                '2. Use of the Application',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Use the App only for educational purposes; do not reverse-engineer, disrupt, or use it for illegal activities.',
              ),
              SizedBox(height: 8),
              Text(
                '3. Account Creation',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Provide accurate info; keep credentials confidential; we are not liable for unauthorized access caused by sharing.',
              ),
              SizedBox(height: 8),
              Text(
                '4. Educational Content',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Materials are for learning only; no guarantees of accuracy or outcomes.',
              ),
              SizedBox(height: 8),
              Text(
                '5. Intellectual Property',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'All content is owned by the developer and cannot be copied or resold without permission.',
              ),
              SizedBox(height: 8),
              Text(
                '6. Prohibited Activities',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'No malware, harassment, unauthorized access, or service disruption.',
              ),
              SizedBox(height: 8),
              Text(
                '7. Privacy & Data Use',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Basic information may be collected for functionality and improvements. See Privacy Policy for details.',
              ),
              SizedBox(height: 8),
              Text(
                '8. Limitation of Liability',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Provided “as is”; we are not liable for damages, data loss, or interruptions.',
              ),
              SizedBox(height: 8),
              Text(
                '9. Modifications',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('We may update features or terms at any time.'),
              SizedBox(height: 8),
              Text(
                '10. Termination',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('We may suspend or terminate access for violations.'),
              SizedBox(height: 8),
              Text(
                '11. Contact',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('logixplore@gmail.com'),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
