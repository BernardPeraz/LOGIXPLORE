import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Condition extends StatefulWidget {
  const Condition({super.key});

  @override
  _ConditionState createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  String _email = '';
  String _code = '';
  String _newPassword = '';
  int _currentStep = 1;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<Map<String, dynamic>?> _findUserByEmail(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return {
          'userId': querySnapshot.docs.first.id,
          'userData': querySnapshot.docs.first.data(),
          'email': querySnapshot.docs.first.data()['Email'],
        };
      }
      return null;
    } catch (e) {
      print('Error finding user: $e');
      return null;
    }
  }

  // IDINAGDAG - Build method na missing
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(20.0), child: _buildStepContent()),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildEmailStep();
      case 2:
        return _buildCodeStep();
      case 3:
        return _buildNewPasswordStep();
      case 4:
        return _buildSuccessStep();
      default:
        return _buildEmailStep();
    }
  }

  // IDINAGDAG - Missing widget methods
  Widget _buildEmailStep() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          onChanged: (value) => _email = value,
        ),
        ElevatedButton(onPressed: _requestResetCode, child: Text('Send Code')),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      children: [
        Text('Code sent to: $_email'),
        TextFormField(
          controller: _codeController,
          decoration: InputDecoration(labelText: 'Verification Code'),
          onChanged: (value) => _code = value,
        ),
        ElevatedButton(onPressed: _verifyCode, child: Text('Verify Code')),
      ],
    );
  }

  Widget _buildNewPasswordStep() {
    return Column(
      children: [
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'New Password'),
          obscureText: true,
          onChanged: (value) => _newPassword = value,
        ),
        ElevatedButton(
          onPressed: _resetPassword,
          child: Text('Reset Password'),
        ),
      ],
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 80),
        Text('Password Reset Successful!'),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Back to Login'),
        ),
      ],
    );
  }

  // IDINAGDAG - Missing functions
  void _requestResetCode() async {
    setState(() => _isLoading = true);
    final user = await _findUserByEmail(_emailController.text);
    if (user != null) {
      setState(() => _currentStep = 2);
    }
    setState(() => _isLoading = false);
  }

  void _verifyCode() {
    setState(() => _currentStep = 3);
  }

  void _resetPassword() {
    setState(() => _currentStep = 4);
  }
}
