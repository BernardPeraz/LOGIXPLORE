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
            shadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
            shape: CircleBorder(),
            image: DecorationImage(image: AssetImage('assets/images/pic.png')),
          ),
        ),
      ),
    ),
  );
}
