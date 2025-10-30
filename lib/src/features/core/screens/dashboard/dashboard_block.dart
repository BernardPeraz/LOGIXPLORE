// buildBlock.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/and.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/deslayout.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/moblayout.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/andlessons.dart';

class buildBlock extends StatefulWidget {
  buildBlock({
    super.key,
    required this.width,
    this.color,
    required this.image,
    required this.text,
  });

  final double width;
  final Color? color;
  final String image;
  final String text;

  @override
  State<buildBlock> createState() => _buildBlockState();
}

class _buildBlockState extends State<buildBlock> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    // ... dispose other controllers
    super.dispose();
  }

  double _progress = 0.0;
  bool _hasBeenCompleted = false;

  void _showOptionsDialog(BuildContext context) {
    final lesson =
        BlocksGate.lessons[widget.text] ??
        {
          'title': widget.text,
          'subtitle': 'Lesson Subtitle',
          'content': 'Lesson content for ${widget.text}...',
        };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isMobile = MediaQuery.of(context).size.width < 600;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                width: DialogController.getDialogWidth(context),
                height: DialogController.getDialogHeight(context),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(158, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: isMobile
                    ? MobileLayout.build(
                        context,
                        lesson,
                        widget.image,
                        onStartLesson: _navigateToLessonPage,
                      )
                    : DesktopLayout.build(
                        context,
                        lesson,
                        widget.image,
                        onStartLesson: _navigateToLessonPage,
                      ),
              ),
              // CLOSE BUTTON - NASA UPPER RIGHT NA
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close, color: Colors.black, size: 24),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToLessonPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SimpleTextImagePage()),
    ).then((result) {
      // When returning from SimpleTextImagePage, check if Done was pressed
      if (result == true && !_hasBeenCompleted) {
        setState(() {
          _progress = 1.0; // Set to 100%
          _hasBeenCompleted = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.width - (widget.width * 0.08),
      color: widget.color,
      padding: EdgeInsets.all(9),
      child: Column(
        children: [
          Image(image: AssetImage(widget.image), width: widget.width),
          Container(height: widget.width * 0.02),
          Row(
            children: [
              Container(
                height: widget.width * 0.120,
                width: 100,
                color: Colors.transparent,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showOptionsDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.transparent),
                      fixedSize: Size(100, widget.width * 0.1),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                      alignment: Alignment.center,
                    ),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.width > 600
                            ? widget.width * 0.045
                            : 16,
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
              Container(
                alignment: Alignment.center,
                width: widget.width * 0.1,
                height: widget.width * 0.1,
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 7,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _progress == 1.0
                        ? Colors.green
                        : const Color.fromARGB(255, 73, 222, 39),
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
