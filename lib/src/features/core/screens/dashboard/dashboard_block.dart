// buildBlock.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/and.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/deslayout.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/moblayout.dart';

class buildBlock extends StatelessWidget {
  buildBlock({
    super.key,
    required this.width,
    this.color,
    required this.image,
    required this.text,
  });

  final double width;
  Color? color;
  final String image;
  final String text;

  void _showOptionsDialog(BuildContext context) {
    final lesson =
        BlocksGate.lessons[text] ??
        {
          'title': text,
          'subtitle': 'Lesson Subtitle',
          'content': 'Lesson content for $text...',
        };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isMobile = MediaQuery.of(context).size.width < 600;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: DialogController.getDialogWidth(context),
            height: DialogController.getDialogHeight(context),
            decoration: BoxDecoration(
              color: const Color.fromARGB(158, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
            ),
            child: isMobile
                ? MobileLayout.build(context, lesson, image)
                : DesktopLayout.build(context, lesson, image),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width - (width * 0.08),
      color: color,

      padding: EdgeInsets.all(9),

      child: Column(
        children: [
          Image(image: AssetImage(image), width: width),
          Container(height: width * 0.02),

          Row(
            children: [
              Container(
                height: width * 0.120,
                width: 100,
                color: Colors.transparent,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showOptionsDialog(context);
                    },
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
                        fontSize: width * 0.052,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(child: Container()),
              Container(
                alignment: Alignment.center,
                width: width * 0.1,
                height: width * 0.1,
                child: CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: 7,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color.fromARGB(255, 73, 222, 39),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
