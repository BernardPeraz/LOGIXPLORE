import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/pageController.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/simulator/widgetts/main.dart';

class WhiteScreen extends StatefulWidget {
  const WhiteScreen({super.key});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  final controller = Get.put(LevelController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      //LogicEditorPage());
      //LogicSimp()

      if (controller.level.value == 1) {
        Get.off(
          () => LogicEditorPage(
            mode: SimulatorMode.level,
            hideSubmitButton: true,
            Equation: "A",
            ExpecOut: [0, 0, 0, 0, 1, 1, 1, 1],
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

            nextPage: () => WhiteScreen(),
          ),
        );
      }
      if (controller.level.value == 2) {
        Get.off(
          () => LogicEditorPage(
            mode: SimulatorMode.level,
            hideSubmitButton: true,
            Equation: "B",
            ExpecOut: [0, 0, 1, 1, 0, 0, 1, 1],
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

            nextPage: () => WhiteScreen(),
          ),
        );
      }
      if (controller.level.value == 3) {
        Get.off(
          () => LogicEditorPage(
            mode: SimulatorMode.level,
            hideSubmitButton: true,
            Equation: "C",
            ExpecOut: [0, 1, 0, 1, 0, 1, 0, 1],
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

            nextPage: () => Dashboard(),
          ),
        );
      }
      if (controller.level.value == 4) {
        Get.off(
          () => LogicEditorPage(
            mode: SimulatorMode.level,
            hideSubmitButton: true,
            Equation: "C",
            ExpecOut: [0, 1, 0, 1, 0, 1, 0, 1],
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

            nextPage: () => Dashboard(),
          ),
        );
      }
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