import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class PerfectUi extends StatefulWidget {
  const PerfectUi({super.key});

  @override
  State<PerfectUi> createState() => _PerfectUiState();
}

class _PerfectUiState extends State<PerfectUi> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();

    _controllerCenter = ConfettiController(duration: const Duration(days: 1));

    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageSize = screenWidth * 0.30; // 30% of screen width
    final closeSize = screenWidth * 0.06; // responsive icon size
    final topPadding = screenHeight * 0.02;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              emissionFrequency: 0.05,
              numberOfParticles: 70,
              gravity: 0.15,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),

            Positioned(
              top: screenHeight * 0.19,
              child: Image.asset(
                'assets/images/background_images/perfectscore.png',
                height: imageSize.clamp(90, 115),
                width: imageSize.clamp(90, 115),
              ),
            ),

            Positioned(
              top: screenHeight * 0.17,
              right: screenWidth * 0.40,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Tooltip(
                  message: 'Close',
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: closeSize.clamp(24, 40),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
