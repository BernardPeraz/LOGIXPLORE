// buildBlock.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/introtopics.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/bufferlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/nandlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/norlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/notlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/orlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/xnorlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/xorlessons.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard_blockuiresponse.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/deslayout.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/moblayout.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/lessons/andlessons.dart';

class BuildBlock extends StatefulWidget {
  const BuildBlock({
    super.key,
    required this.width,
    this.color,
    required this.image,
    required this.text,
    required double progress,
  });

  final double width;
  final Color? color;
  final String image;
  final String text;

  @override
  State<BuildBlock> createState() => _BuildBlockState();
}

class _BuildBlockState extends State<BuildBlock> {
  double _progress = 0.0;
  bool _hasBeenCompleted = false;
  Set<String> _completedPdfs = {};

  int _getTotalPagesForBlock(String blockName) {
    switch (blockName.toUpperCase()) {
      case 'AND GATE':
      case 'AND':
        return Andlessons.lessons.length;

      case 'NOT AND':
      case 'NAND':
        return Nandlessons.lessons.length;

      case 'OR GATE':
      case 'OR':
        return Orlessons.lessons.length;

      case 'NOT OR GATE':
      case 'NOR':
        return Norlessons.lessons.length;

      case 'NOT GATE':
      case 'NOT':
        return Notlessons.lessons.length;

      case 'EXCLUSIVE OR GATE':
      case 'XOR':
        return Xorlessons.lessons.length;

      case 'EXCLUSIVE NOR GATE':
      case 'XNOR':
        return Xnorlessons.lessons.length;

      case 'BUFFER GATE':
      case 'BUFFER':
        return Bufferlessons.lessons.length;

      default:
        return 1;
    }
  }

  int _getTotalLessonsForBlock(String blockName) {
    switch (blockName.toUpperCase()) {
      case 'AND GATE':
      case 'AND':
        return Andlessons.lessons.length;

      case 'NOT AND':
      case 'NAND':
        return Nandlessons.lessons.length;

      case 'OR GATE':
      case 'OR':
        return Orlessons.lessons.length;

      case 'NOT OR GATE':
      case 'NOR':
        return Norlessons.lessons.length;

      case 'NOT GATE':
      case 'NOT':
        return Notlessons.lessons.length;

      case 'EXCLUSIVE OR GATE':
      case 'XOR':
        return Xorlessons.lessons.length;

      case 'EXCLUSIVE NOR GATE':
      case 'XNOR':
        return Xnorlessons.lessons.length;

      case 'BUFFER GATE':
      case 'BUFFER':
        return Bufferlessons.lessons.length;

      default:
        return 0;
    }
  }

  bool get isTaskCompleted => _progress == 1.0;

  void _onPdfClicked(String pdfPath) {
    setState(() {
      if (!_completedPdfs.contains(pdfPath)) {
        _completedPdfs.add(pdfPath);

        int totalLessons = _getTotalLessonsForBlock(widget.text);
        _progress = _completedPdfs.length / totalLessons;

        if (_progress > 1.0) _progress = 1.0;
        if (_progress == 1.0) _hasBeenCompleted = true;

        print('Progress updated: ${(_progress * 100).toStringAsFixed(0)}%');
        print('Completed PDFs: $_completedPdfs');
      }
    });
  }

  void updateProgress(int pagesCompleted) {
    setState(() {
      int totalPages = _getTotalLessonsForBlock(widget.text);
      _progress = pagesCompleted / totalPages;
      if (_progress == 1.0) _hasBeenCompleted = true;
    });
  }

  void _showOptionsDialog(BuildContext context) {
    final lesson =
        IntroTopics.lessons[widget.text] ??
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
                  color: const Color.fromARGB(225, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: isMobile
                    ? MobileLayout.build(
                        context,
                        lesson,
                        widget.image,
                        progress: _progress,
                        onStartLesson: _navigateToLessonPage,
                      )
                    : DesktopLayout.build(
                        context,
                        lesson,
                        widget.image,
                        progress: _progress,
                        onStartLesson: _navigateToLessonPage,
                      ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, color: Colors.black, size: 24),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToLessonPage() {
    final Map<String, Widget> lessonPages = {
      'AND GATES': Andlessons(onPdfClicked: _onPdfClicked),
      'AND': Andlessons(onPdfClicked: _onPdfClicked),
      'NAND GATES': Nandlessons(onPdfClicked: _onPdfClicked),
      'NAND': Nandlessons(onPdfClicked: _onPdfClicked),
      'OR GATE': Orlessons(onPdfClicked: _onPdfClicked),
      'OR': Orlessons(onPdfClicked: _onPdfClicked),
      'NOR GATE': Norlessons(onPdfClicked: _onPdfClicked),
      'NOR': Norlessons(onPdfClicked: _onPdfClicked),
      'NOT GATE': Notlessons(onPdfClicked: _onPdfClicked),
      'NOT': Notlessons(onPdfClicked: _onPdfClicked),
      'XOR GATE': Xorlessons(onPdfClicked: _onPdfClicked),
      'XOR': Xorlessons(onPdfClicked: _onPdfClicked),
      'XNOR GATE': Xnorlessons(onPdfClicked: _onPdfClicked),
      'XNOR': Xnorlessons(onPdfClicked: _onPdfClicked),
      'BUFFER GATE': Bufferlessons(onPdfClicked: _onPdfClicked),
      'BUFFER': Bufferlessons(onPdfClicked: _onPdfClicked),
    };

    // Kunin page base sa text
    final Widget? selectedPage = lessonPages[widget.text.toUpperCase().trim()];

    if (selectedPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => selectedPage),
      ).then((result) {
        if (result != null && result is int) {
          int pagesCompleted = result;
          updateProgress(pagesCompleted);
        } else if (result == true && !_hasBeenCompleted) {
          int totalPages = _getTotalPagesForBlock(widget.text);
          if (totalPages == 1) {
            setState(() {
              _progress = 1.0;
              _hasBeenCompleted = true;
            });
          }
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No lesson page found for ${widget.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BuildBlockUI.build(
      context,
      width: widget.width,
      color: widget.color,
      image: widget.image,
      text: widget.text,
      progress: _progress,
      onButtonPressed: () {
        _showOptionsDialog(context);
      },
    );
  }
}
