import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LevelController extends GetxController {
  var level = 1.obs;

  void next() {
    level++;
  }

  void random() {
    final rand = Random();
    level.value = rand.nextInt(10) + 1;
  }
}
