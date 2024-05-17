import 'package:flutter/material.dart';
import 'register_screen.dart'; // Import the RegisterScreen

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50), // Adds some space from the top of the screen
              Text(
                'GETTİR',
                style: TextStyle(
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(fontSize: 70),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 70),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                ),
                obscureText: true,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Handle login
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: Text('Login', style: TextStyle(fontSize: 40)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to RegisterScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                  // Handle registration
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: Text('Register', style: TextStyle(fontSize: 40)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
