import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gettir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //change home: to the view to be testes
      home: LoginScreen(),
    );
  }
}