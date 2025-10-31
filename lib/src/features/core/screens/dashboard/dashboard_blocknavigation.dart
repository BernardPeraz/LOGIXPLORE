// buildBlock.dart
import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/blocks/and.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/dashboard_blockuiresponse.dart';
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
    required double progress,
  });

  final double width;
  final Color? color;
  final String image;
  final String text;

  @override
  State<buildBlock> createState() => _buildBlockState();
}

class _buildBlockState extends State<buildBlock> {
  double _progress = 0.0;
  bool _hasBeenCompleted = false;

  // DAGDAG: Method para makuha ang total pages para sa bawat block
  int _getTotalPagesForBlock(String blockName) {
    switch (blockName.toUpperCase()) {
      case 'AND GATE':
      case 'AND':
        return 1; // Isa lang ang page para sa AND Gate

      case 'NOT AND':
      case 'NAND':
        return 1; // Apat na pages para sa OR Gate

      case 'OR GATE':
      case 'OR':
        return 1; // Tatlong pages para sa NOT Gate

      case 'NOT OR GATE':
      case 'NOR':
        return 1; // Dalawang pages para sa NAND Gate

      case 'NOT GATE':
      case 'NOT':
        return 1; // Limang pages para sa NOR Gate

      case 'EXCLUSIVE OR GATE':
      case 'XOR':
        return 1; // Tatlong pages para sa XOR Gate

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

  // DAGDAG: Getter para sa task completion status
  bool get isTaskCompleted => _progress == 1.0;

  // DAGDAG: Method para i-update ang progress
  void updateProgress(int pagesCompleted) {
    setState(() {
      int totalPages = _getTotalPagesForBlock(widget.text);
      _progress = pagesCompleted / totalPages;

      // I-check kung complete na
      if (_progress == 1.0) {
        _hasBeenCompleted = true;
      }
    });
  }

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
      // DAGDAG: Modified logic para sa multiple pages
      if (result != null && result is int) {
        // Kapag may binigay na pages completed
        int pagesCompleted = result;
        updateProgress(pagesCompleted);
      } else if (result == true && !_hasBeenCompleted) {
        // Para sa backward compatibility - AND Gate (1 page)
        int totalPages = _getTotalPagesForBlock(widget.text);
        if (totalPages == 1) {
          setState(() {
            _progress = 1.0;
            _hasBeenCompleted = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BuildBlockUI.build(
      // USE THE RENAMED CLASS
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
