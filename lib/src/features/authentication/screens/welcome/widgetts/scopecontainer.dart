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
          height: isDesktop ? 50 : 24, // CONDITIONAL: Mas maliit sa mobile
        ),
      ),
      Flexible(
        flex: 20,
        child: Container(
          height: isDesktop ? 55 : 50, // CONDITIONAL: Mas maliit sa mobile
          color: Colors.black,
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
