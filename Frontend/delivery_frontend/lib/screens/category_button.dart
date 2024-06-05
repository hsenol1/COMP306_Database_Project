import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String name;

  CategoryButton({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle category button press
        },
        child: Text(name),
      ),
    );
  }
}
