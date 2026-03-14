import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class LogixApi {
  static const String baseUrl = "http://localhost:3000";

  static Future<List<Question>> fetchQuiz(String gate) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/questions"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "gate": gate, // 👈 send gate type
      }),
    );

    final data = jsonDecode(response.body);

    return (data['questions'] as List)
        .map((q) => Question.fromJson(q))
        .toList();
  }
}
