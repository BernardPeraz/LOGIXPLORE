import 'package:flutter/material.dart';

Future<void> showLoadingBeforeDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  await Future.delayed(const Duration(seconds: 2));

  Navigator.pop(context);
}
