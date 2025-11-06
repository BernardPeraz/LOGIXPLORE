// taskbutton.dart
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/authentication/controllers/dialog_controller.dart';
import 'package:studydesign2zzdatabaseplaylist/src/features/core/screens/dashboard/choices.dart';

class TaskButton extends StatefulWidget {
  final double progress; // ADD THIS: parameter para sa progress

  const TaskButton({
    super.key,
    required this.progress,
  }); // ADD THIS: constructor

  @override
  _TaskButtonState createState() => _TaskButtonState();
}

class _TaskButtonState extends State<TaskButton> {
  bool isTaskCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Condition para magpalit ng button type
        // Sa loob ng build method_
        (widget.progress ==
                1.0) // CHANGE: gamitin ang widget.progress instead of _progress
            ? SizedBox(
                width: DialogController.getButtonWidth(context),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Assessment()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.transparent),
                    backgroundColor:
                        Colors.green, // Pwedeng ibang color kapag completed
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check), // Palit icon kapag completed
                      SizedBox(width: 8), // spacing between icon and text
                      Flexible(
                        child: Text(
                          'START ASSESSMENT',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow
                              .ellipsis, // Show ... if text is too long
                          softWrap: false, // Prevent wrapping to next line
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the content
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.lock),
                      // Add spacing between icon and text
                      Expanded(
                        // This will prevent overflow
                        child: Text(
                          'READ THE LESSONS FIRST',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13, // Adjust font size if needed
                          ),
                          overflow: TextOverflow.ellipsis, // Handle long text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
