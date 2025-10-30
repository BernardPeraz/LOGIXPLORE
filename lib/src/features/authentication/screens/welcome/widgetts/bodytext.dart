import 'package:flutter/material.dart';

Widget BodyText(double width, bool isDesktop) {
  return Expanded(
    flex: 4,
    child: Container(
      // Mas magandang height calculation base sa screen size
      height: isDesktop ? 355 : 245,
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isDesktop ? 10 : 8),
            FittedBox(
              // Mag-aauto-adjust ng text size para magkasya sa screen
              fit: BoxFit.scaleDown,
              child: Text(
                "LOGIXPLORE",
                style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(3, 6),
                      blurRadius: 2,
                      color: Colors.black.withValues(alpha: 100),
                    ),
                  ],
                  fontSize: isDesktop ? width * 0.07 : width * 0.12,
                  fontFamily: 'Headline',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: isDesktop ? 10 : 8),
            Divider(
              color: Colors.black,
              thickness: isDesktop ? 7 : 4,
              indent: isDesktop ? 25 : width * 0.14, // Percentage-based indent
              endIndent: isDesktop ? 60 : width * 0.19, // Balanced on mobile
            ),
            SizedBox(height: isDesktop ? 20 : 1),
            FittedBox(
              // Auto-adjust din para sa subtitle
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Small circuits can make big impact!",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(4, 0),
                        blurRadius: 16,
                        color: Colors.black.withValues(alpha: 100),
                      ),
                    ],
                    fontSize: isDesktop ? width * 0.03 : width * 0.04,
                    fontFamily: 'Headline',
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 255, 149, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
