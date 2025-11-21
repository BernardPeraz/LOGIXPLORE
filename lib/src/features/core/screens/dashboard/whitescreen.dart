import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/main.dart';

class WhiteScreen extends StatefulWidget {
  const WhiteScreen({super.key});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //LogicEditorPage());
      //LogicSimp()
      Get.off(
        () => LogicEditorPage(
          ExpecOut: [0, 0, 0, 0, 0, 0, 0, 1],
          allowedGates: [
            "AND",
            "OR",
            "BUFFER",
            "NOT",
            "NAND",
            "NOR",
            "XOR",
            "XNOR",
          ],
          nextPage: Dashboard(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 23, 77, 225),
        ),
      ),
    );
  }
}
//LogicSimp()