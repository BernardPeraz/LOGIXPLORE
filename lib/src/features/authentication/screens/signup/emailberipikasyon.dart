import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailVerificationService {
  final String apiUrl = "https://your-cloud-function-url/sendVerificationEmail";

  /// Sends an OTP email through backend (Cloud Function / API)
  Future<bool> sendVerificationEmail(String userEmail) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': userEmail}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Failed to send verification email: ${response.body}');
      return false;
    }
  }

  /// Verifies OTP from the user input
  Future<bool> verifyOTP(String email, String otp) async {
    final response = await http.post(
      Uri.parse("https://your-cloud-function-url/verifyOtp"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['verified'] == true;
    } else {
      debugPrint('OTP verification failed');
      return false;
    }
  }
}
