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
      if (controller.difficulty.value == 1) {
        if (controller.level.value == 1) {
          Get.off(
            () =>
                Level(Equation: "(A ⋅ C)'", ExpecOut: [1, 1, 1, 1, 1, 0, 1, 0]),
          );
        }
        if (controller.level.value == 2) {
          Get.off(
            () => Level(Equation: "A + B'", ExpecOut: [1, 1, 0, 0, 1, 1, 1, 1]),
          );
        }
        if (controller.level.value == 3) {
          Get.off(
            () =>
                Level(Equation: "(B ⋅ C)'", ExpecOut: [1, 1, 1, 0, 1, 1, 1, 0]),
          );
        }
        if (controller.level.value == 4) {
          Get.off(
            () =>
                Level(Equation: "(B + C)'", ExpecOut: [1, 0, 0, 0, 1, 0, 0, 0]),
          );
        }
        if (controller.level.value == 5) {
          Get.off(
            () =>
                Level(Equation: "A' ⋅ B'", ExpecOut: [1, 1, 0, 0, 0, 0, 0, 0]),
          ); //⊕
        }
        if (controller.level.value == 6) {
          Get.off(
            () => Level(Equation: "B ⊕ C", ExpecOut: [0, 1, 1, 0, 0, 1, 1, 0]),
          );
        }
        if (controller.level.value == 7) {
          Get.off(
            () =>
                Level(Equation: "(A ⊕ C)'", ExpecOut: [1, 0, 1, 0, 0, 1, 0, 1]),
          );
        }
        if (controller.level.value == 8) {
          Get.off(
            () =>
                Level(Equation: "(A + B)'", ExpecOut: [1, 1, 0, 0, 0, 0, 0, 0]),
          );
        }
        if (controller.level.value == 9) {
          Get.off(
            () => Level(Equation: "A' ⊕ B", ExpecOut: [1, 1, 0, 0, 0, 0, 1, 1]),
          );
        }
        if (controller.level.value == 10) {
          Get.off(
            () => Level(Equation: "B + C'", ExpecOut: [1, 0, 1, 1, 1, 0, 1, 1]),
          );
        }
      } //Easy
      if (controller.difficulty.value == 2) {
        if (controller.level.value == 1) {
          Get.off(
            () => Level(
              Equation: "((A ⋅ B) + C')'",
              ExpecOut: [0, 1, 0, 1, 0, 1, 0, 0],
            ),
          );
        }
        if (controller.level.value == 2) {
          Get.off(
            () => Level(
              Equation: "(A ⋅ B)' ⊕ B",
              ExpecOut: [1, 1, 0, 0, 1, 1, 1, 1],
            ),
          );
        }
        if (controller.level.value == 3) {
          Get.off(
            () => Level(
              Equation: "C' + (B ⋅ A')'",
              ExpecOut: [1, 1, 1, 0, 1, 1, 1, 1],
            ),
          );
        }
        if (controller.level.value == 4) {
          Get.off(
            () => Level(
              Equation: "((B ⋅ C)' ⊕ C')'",
              ExpecOut: [1, 0, 1, 1, 1, 0, 1, 1],
            ),
          );
        }
        if (controller.level.value == 5) {
          Get.off(
            () => Level(
              Equation: "(A ⋅ C)' ⊕ B",
              ExpecOut: [1, 1, 0, 0, 1, 0, 0, 1],
            ),
          );
        }
        if (controller.level.value == 6) {
          Get.off(
            () => Level(
              Equation: "((A + B) + C)'",
              ExpecOut: [1, 0, 0, 0, 0, 0, 0, 0],
            ),
          );
        }
        if (controller.level.value == 7) {
          Get.off(
            () => Level(
              Equation: "B + (A ⋅ C')",
              ExpecOut: [0, 0, 1, 1, 1, 0, 1, 1],
            ),
          );
        }
        if (controller.level.value == 8) {
          Get.off(
            () => Level(
              Equation: "((A ⋅ B)' + C)'",
              ExpecOut: [0, 0, 0, 0, 0, 0, 1, 0],
            ),
          );
        }
        if (controller.level.value == 9) {
          Get.off(
            () => Level(
              Equation: "((B ⋅ C)' ⋅ B)'",
              ExpecOut: [1, 1, 0, 1, 1, 1, 0, 1],
            ),
          );
        }
        if (controller.level.value == 10) {
          Get.off(
            () => Level(
              Equation: "(A ⋅ C)' + B'",
              ExpecOut: [1, 1, 1, 1, 1, 1, 1, 0],
            ),
          );
        }
      } //Medium
      if (controller.difficulty.value == 3) {
        if (controller.level.value == 1) {
          Get.off(
            () => Level(
              Equation: "((A + B) ⊕ (B ⋅ C')')'",
              ExpecOut: [0, 0, 0, 1, 1, 1, 0, 1],
            ),
          );
        }
        if (controller.level.value == 2) {
          Get.off(
            () => Level(
              Equation: "((B' ⋅ A)' + (A ⊕ C'))'",
              ExpecOut: [0, 0, 0, 0, 1, 0, 0, 0],
            ),
          );
        }
        if (controller.level.value == 3) {
          Get.off(
            () => Level(
              Equation: "(A ⋅ C')' ⊕ (C + B)'",
              ExpecOut: [0, 1, 1, 1, 1, 1, 0, 1],
            ),
          );
        }
        if (controller.level.value == 4) {
          Get.off(
            () => Level(
              Equation: "(B ⋅ A) + (A' + C')'",
              ExpecOut: [0, 0, 0, 0, 0, 1, 1, 1],
            ),
          );
        }
        if (controller.level.value == 5) {
          Get.off(
            () => Level(
              Equation: "(A ⋅ B) + (B + C')'",
              ExpecOut: [0, 1, 0, 0, 0, 1, 1, 1],
            ),
          );
        }
        if (controller.level.value == 6) {
          Get.off(
            () => Level(
              Equation: "((A ⊕ B) ⋅ (B + C))'",
              ExpecOut: [1, 1, 0, 0, 1, 0, 1, 1],
            ),
          );
        }
        if (controller.level.value == 7) {
          Get.off(
            () => Level(
              Equation: "((C + A') + (A ⋅ B)')'",
              ExpecOut: [0, 0, 0, 0, 0, 0, 1, 0],
            ),
          );
        }
        if (controller.level.value == 8) {
          Get.off(
            () => Level(
              Equation: "((C + A) + (A' ⋅ B')')'",
              ExpecOut: [1, 0, 0, 0, 0, 0, 0, 0],
            ),
          );
        }
        if (controller.level.value == 9) {
          Get.off(
            () => Level(
              Equation: "(B ⊕ A)' ⊕ (A + C')",
              ExpecOut: [0, 1, 1, 0, 1, 1, 0, 0],
            ),
          );
        }
        if (controller.level.value == 10) {
          Get.off(
            () => Level(
              Equation: "(B' + A) ⊕ (A + C')'",
              ExpecOut: [1, 0, 0, 1, 1, 1, 1, 1],
            ),
          );
        }
      } //Hard
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

class Level extends LogicEditorPage {
  Level({required String Equation, required List<int> ExpecOut, super.key})
    : super(
        mode: SimulatorMode.level,
        hideSubmitButton: true,
        Equation: Equation,
        ExpecOut: ExpecOut,
        allowedGates: const [
          "NOT",
          "AND",
          "NAND",
          "OR",
          "NOR",
          "XOR",
          "XNOR",
          "BUFFER",
        ],
        nextPage: () => WhiteScreen(),
      );
}
