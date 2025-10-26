// Sa kahit anong screen/page, gamitin ang:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/main.dart';

class AnyScreen extends StatelessWidget {
  void _loadWebsite() {
    // Start loading
    Get.find<AppLoadingController>().startLoading();

    // Simulate website loading
    Future.delayed(Duration(seconds: 3)).then((_) {
      // Stop loading when done
      Get.find<AppLoadingController>().stopLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _loadWebsite,
          child: Text('Load Website'),
        ),
      ),
    );
  }
}
