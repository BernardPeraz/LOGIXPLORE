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
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(250, 255, 149, 0),
            shadowColor: Colors.black,
            elevation: 15,
          ),
          onPressed: () {},
          child: Container(
            height: isDesktop ? 55 : 50, // CONDITIONAL: Mas maliit sa mobile
            color: const Color.fromARGB(250, 255, 149, 0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: isDesktop
                      ? 17
                      : 18, // CONDITIONAL: Mas maliit sa mobile
                  fontWeight: FontWeight.w900,

                  color: Colors.black,
                ),
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
