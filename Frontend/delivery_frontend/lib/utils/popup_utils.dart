import 'package:flutter/material.dart';

void showErrorPopup(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error', style: TextStyle(fontSize: 24)),
        content: Text(errorMessage, style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK', style: TextStyle(fontSize: 18)),
          ),
        ],
      );
    },
  );
}
