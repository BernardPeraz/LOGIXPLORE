import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJsService {
  static const _serviceId = 'service_4m43z6s';
  static const _templateId = 'template_2o6xcpo';
  static const _publicKey = 'cJqeNjQlDxwgHpMh3';

  static Future<bool> sendOtp(String email, String otp) async {
    const url = 'https://api.emailjs.com/api/v1.0/email/send';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'origin': 'logixplore.online',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _publicKey,
        'template_params': {'email': email, 'otp': otp},
      }),
    );
    print("EmailJS raw response: ${response.statusCode} | ${response.body}");

    return response.statusCode == 200;
  }
}
