// build_block_ui.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/conditionassessment/hoverimage.dart';

class BuildBlockUI {
  // CHANGE: Rename to BuildBlockUI
  static Widget build(
    BuildContext context, {
    required double width,
    required Color? color,
    required String image,
    required String text,
    required double progress,
    required VoidCallback onButtonPressed,
  }) {
    return Container(
      width: width,
      height: width - (width * 0.08),
      color: color,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 9),
      child: Column(
        children: [
          HoverImage(image: image, width: width),
          Container(height: width * 0.02),
          Row(
            children: [
              Container(
                height: width * 0.120,
                width: 60,
                color: Colors.transparent,
                child: Center(
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.transparent),
                      fixedSize: Size(100, width * 0.1),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                      alignment: Alignment.center,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width > 600 ? width * 0.045 : 16,
                        fontWeight: FontWeight.bold,
                        height: 0.3,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.1,
                    height: width * 0.1,
                    child: CircularProgressIndicator(
                      value: progress,

                      strokeWidth: 6,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress == 1.0
                            ? Colors.green
                            : const Color.fromARGB(255, 73, 222, 39),
                      ),
                    ),
                  ),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}%', // shows 0% - 100%
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
