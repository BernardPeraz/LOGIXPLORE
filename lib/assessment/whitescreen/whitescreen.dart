import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhiteScreen extends StatefulWidget {
  final Widget nextPage;

  const WhiteScreen({super.key, required this.nextPage});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  @override
  void initState() {
    super.initState();

    // Delay before going to next page
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return; // prevents setState after dispose error
      Get.off(() => widget.nextPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo/logicon.png', height: 40, width: 40),
                const SizedBox(width: 8),
                const Text(
                  'Preparing your questions...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const CircularProgressIndicator(color: Colors.blue),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Get ready,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'LogiXmate',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
