import 'package:flutter/material.dart';

class AchievementDialog extends StatelessWidget {
  final int currentScore;
  final int totalQuestions;
  final int bestScore;
  final List lessonProgress;
  final List<Map<String, String>> earnedBadges;
  const AchievementDialog({
    super.key,
    required this.currentScore,
    required this.totalQuestions,
    required this.bestScore,
    required this.earnedBadges,
    required this.lessonProgress,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final titleSize = (screenWidth * 0.04).clamp(14, 22).toDouble();
    final badgeSize = (screenWidth * 0.18).clamp(55, 125).toDouble();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TOP SCORES ROW
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Recent Score\n$currentScore / $totalQuestions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Best Score!\n$bestScore',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenWidth * 0.03),

              /// BADGE SECTION TITLE
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Achievements Earned',
                  style: TextStyle(
                    fontSize: titleSize + 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: screenWidth * 0.02),

              /// BADGES
              Wrap(
                spacing: 20,
                runSpacing: 18,
                alignment: WrapAlignment.center,
                children: earnedBadges.map((badge) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          badge['image']!,
                          width: badgeSize,
                          height: badgeSize,
                        ),
                        SizedBox(height: 2),
                        Text(
                          badge['title']!,
                          style: TextStyle(
                            fontSize: titleSize * 0.9,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: screenWidth * 0.06),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 128, 0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 39,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
