import 'package:flutter/material.dart';

class DynamicQuizUI extends StatefulWidget {
  final String question;
  final List<String> choices;
  final String answer;
  int selectedIndex;
  int chance;

  DynamicQuizUI({
    super.key,
    required this.question,
    required this.choices,
    required this.answer,
    required this.selectedIndex,
    required this.chance,
  });

  @override
  State<DynamicQuizUI> createState() => _DynamicQuizUIState();
}

class _DynamicQuizUIState extends State<DynamicQuizUI> {
  // ⭐ MUST BE HERE (outside build)

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              widget.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ...widget.choices.map((choice) {
              int index = widget.choices.indexOf(choice);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (widget.chance == 0) {
                      setState(() {
                        widget.selectedIndex = index; // ⭐ Save clicked index
                      });
                      widget.chance = 1;
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (choice == widget.answer)
                          ? widget.selectedIndex == index
                                ? Colors
                                      .green // ⭐ CLICKED COLOR
                                : Colors.black.withValues(alpha: 0.85)
                          : widget.selectedIndex == index
                          ? Colors
                                .orange // ⭐ CLICKED COLOR
                          : Colors.black.withValues(alpha: 0.85),
                    ),
                    child: Text(
                      choice,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
