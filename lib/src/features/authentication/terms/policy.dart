import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('Last Updated: [Insert Date]'),
              SizedBox(height: 16),
              Text(
                'This Privacy Policy explains how LogicGates collects, uses, and protects information when you use the App.',
                style: TextStyle(height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                '1. Information We Collect',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '• You provide: username, email (if accounts are enabled)\n'
                '• Automatically: device info, usage data, crash logs\n'
                '• We do not intentionally collect sensitive data',
              ),
              SizedBox(height: 8),
              Text(
                '2. How We Use Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Provide and improve educational features, maintain functionality and security, respond to support.',
              ),
              SizedBox(height: 8),
              Text(
                '3. Sharing & Disclosure',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'No sale of data; limited sharing with service providers; legal compliance if required.',
              ),
              SizedBox(height: 8),
              Text(
                '4. Data Retention & Security',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'We keep data as needed and use reasonable security measures, but no system is 100% secure.',
              ),
              SizedBox(height: 8),
              Text(
                '5. Children’s Privacy',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Use only with appropriate consent if under the legal age in your region.',
              ),
              SizedBox(height: 8),
              Text(
                '6. Your Rights',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'You may request access, correction, deletion, or export. Contact: logixplore@gmail.com.',
              ),
              SizedBox(height: 8),
              Text(
                '7. International Transfers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Data may be processed in other countries with appropriate safeguards.',
              ),
              SizedBox(height: 8),
              Text(
                '8. Third-Party Links',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('External resources follow their own policies.'),
              SizedBox(height: 8),
              Text('9. Changes', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'We may update this Policy; continued use is acceptance of changes.',
              ),
              SizedBox(height: 8),
              Text(
                '10. Contact',
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
