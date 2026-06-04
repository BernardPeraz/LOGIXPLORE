import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LevelController extends GetxController {
  var level = 1.obs;
  final difficulty = 1.obs; // 1, 2, or 3

  void next() {
    level++;
  }

  void random() {
    final rand = Random();
    level.value = rand.nextInt(10) + 1;
  }

  void setDifficulty(int value) {
    if (value >= 1 && value <= 3) {
      difficulty.value = value;
    }
  }
}
