import 'package:flutter/material.dart';
import 'category_button.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                CategoryButton(name: 'Category 1'),
                CategoryButton(name: 'Category 2'),
                CategoryButton(name: 'Category 3'),
                CategoryButton(name: 'Category 4'),
                CategoryButton(name: 'Category 4'),
                CategoryButton(name: 'Category 4'),
                CategoryButton(name: 'Category 4'),
                CategoryButton(name: 'Category 4'),
                CategoryButton(name: 'Category 4'),
                CategoryButton(name: 'Category 4'),
              ],
            ),
          ),
        ),
        // Add more content here for the home screen
        Expanded(
          child: Center(
            child: Text('Home Screen Content'),
          ),
        ),
      ],
    );
  }
}
