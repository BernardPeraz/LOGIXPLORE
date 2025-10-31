import 'package:flutter/material.dart';

class SimpleTextImagePage extends StatefulWidget {
  const SimpleTextImagePage({super.key});

  @override
  State<SimpleTextImagePage> createState() => _SimpleTextImagePageState();
}

class _SimpleTextImagePageState extends State<SimpleTextImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        // Return true to indicate completion
                        Navigator.pop(context, true);
                      },
                      child: Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
