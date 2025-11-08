import 'package:flutter/material.dart';

class Masterwidget extends StatefulWidget {
  const Masterwidget({super.key});

  @override
  State<Masterwidget> createState() => _MasterwidgetState();
}

class _MasterwidgetState extends State<Masterwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'On going proces...',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
