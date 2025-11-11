import 'package:flutter/material.dart';

Widget ScopeContainer(
  int firstSpace,
  int ActualContainer,
  int lastSpace,
  String text,
  bool isDesktop, // DAGDAG: Added isDesktop parameter
) {
  return Row(
    children: [
      Flexible(
        flex: firstSpace,
        child: Container(
          height: isDesktop ? 50 : 24,
          // CONDITIONAL: Mas maliit sa mobile
        ),
      ),
      Flexible(
        flex: 25,
        child: Container(
          height: isDesktop ? 55 : 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(250, 255, 149, 0),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isDesktop ? 17 : 18,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      Flexible(
        flex: lastSpace,
        child: Container(
          height: isDesktop ? 40 : 45, // CONDITIONAL: Mas maliit sa mobile
        ),
      ),
    ],
  );
}
