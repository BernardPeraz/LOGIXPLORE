import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studydesign2zzdatabaseplaylist/src/constants/image_strings.dart';

class Masterwidget extends StatefulWidget {
  const Masterwidget({super.key});

  @override
  State<Masterwidget> createState() => _MasterwidgetState();
}

class _MasterwidgetState extends State<Masterwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logicon.png', height: 9, width: 5),
        title: Text(
          "PASSWORD SETTINGS",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 1,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 16.0)),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? BackgroundImageLight
                : BackgroundImageDark,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Text(
              'On going proces...',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
