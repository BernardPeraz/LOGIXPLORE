// buildBlock.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/IntrotopicS.dart';
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

  int _getTotalPagesForBlock(String blockName) {
    switch (blockName.toUpperCase()) {
      case 'AND GATE':
      case 'AND':
        return 1;

      case 'NOT AND':
      case 'NAND':
        return 1;

      case 'OR GATE':
      case 'OR':
        return 1;

      case 'NOT OR GATE':
      case 'NOR':
        return 1;

      case 'NOT GATE':
      case 'NOT':
        return 1;

      case 'EXCLUSIVE OR GATE':
      case 'XOR':
        return 1;

      case 'EXCLUSIVE NOR GATE':
      case 'XNOR':
        return 1;

      case 'BUFFER GATE':
      case 'BUFFER':
        return 1;

      default:
        return 1;
    }
  }

  bool get isTaskCompleted => _progress == 1.0;

  void updateProgress(int pagesCompleted) {
    setState(() {
      int totalPages = _getTotalPagesForBlock(widget.text);
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
                  color: const Color.fromARGB(158, 255, 255, 255),
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

  // 🧠 BINAGO LANG: conditional navigation logic (using Map)
  void _navigateToLessonPage() {
    // Map ng topics at corresponding pages
    final Map<String, Widget> lessonPages = {
      'AND GATES': const Andlessons(),
      'AND': const Andlessons(),
      'NAND GATE': const Nandlessons(),
      'NAND': const Nandlessons(),
      'OR GATE': const Orlessons(),
      'OR': const Orlessons(),
      'NOR GATE': const Norlessons(),
      'NOR': const Norlessons(),
      'NOT GATE': const Notlessons(),
      'NOT': const Notlessons(),
      'XOR GATE': const Xorlessons(),
      'XOR': const Xorlessons(),
      'XNOR GATE': const Xnorlessons(),
      'XNOR': const Xnorlessons(),
      'BUFFER GATE': const Bufferlessons(),
      'BUFFER': const Bufferlessons(),
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
      // Fallback kapag walang matching page
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
