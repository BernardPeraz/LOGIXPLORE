import 'package:flutter/material.dart';

class AchievementDialog extends StatelessWidget {
  final int currentScore;
  final int totalQuestions;
  final int bestScore;
  final List<Map<String, String>> earnedBadges;
  const AchievementDialog({
    super.key,
    required this.currentScore,
    required this.totalQuestions,
    required this.bestScore,
    required this.earnedBadges,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final titleSize = (screenWidth * 0.04).clamp(14, 22).toDouble();
    final badgeSize = (screenWidth * 0.18).clamp(55, 95).toDouble();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
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
                        color: Colors.orange.withOpacity(0.15),
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
                          SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
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

              SizedBox(height: screenWidth * 0.04),

              /// BADGE SECTION TITLE
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Achievements Earned',
                  style: TextStyle(
                    fontSize: titleSize + 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: screenWidth * 0.03),

              /// BADGES
              Wrap(
                spacing: 18,
                runSpacing: 18,
                alignment: WrapAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/background_images/perfectscore.png',
                        width: badgeSize,
                        height: badgeSize,
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Module Complete',
                        style: TextStyle(fontSize: titleSize * 0.9),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Image.asset(
                        'assets/images/background_images/perfectscore.png',
                        width: badgeSize,
                        height: badgeSize,
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Perfect Score',
                        style: TextStyle(fontSize: titleSize * 0.9),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: screenWidth * 0.06),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
