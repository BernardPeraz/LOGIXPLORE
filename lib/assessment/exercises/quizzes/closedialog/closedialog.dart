import 'package:flutter/material.dart';

void showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // hindi mawawala pag nagclick sa labas
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Are you sure?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "If you close it, you will start again. Do you want to continue?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // close dialog
              // close dialog only
            },
            child: Text("Yes,Close", style: TextStyle(color: Colors.red)),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
            },
            child: Text("Cancel", style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    },
  );
}
