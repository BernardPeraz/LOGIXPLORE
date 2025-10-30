import 'package:flutter/material.dart';

Widget ImageContainer(double width, bool isDesktop) {
  return Expanded(
    flex: 2,
    child: Container(
      height: isDesktop == true ? 450 : width * 0.5,
      child: Center(
        child: Container(
          height: isDesktop == true ? 350 : width * 0.5,
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            image: DecorationImage(image: AssetImage('assets/images/pic.png')),
          ),
        ),
      ),
    ),
  );
}
