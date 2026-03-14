class Question {
  final String question;
  final List<String> choices;
  final String correctAnswer;

  Question({
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      choices: List<String>.from(json['choices']),
      correctAnswer: json['correctAnswer'],
    );
  }
}
