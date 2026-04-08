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

    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 10),
    );

    _controllerCenter.play(); // Auto start
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false, // Auto stop after duration
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),

            Image.asset(
              'assets/images/background_images/perfectscore.png',
              height: 120,
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}
