import 'package:delivery_frontend/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart'; // Import the RegisterScreen
import 'admin_page.dart'; // Import the AdminPage

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 30), // Adds some space from the top of the screen
              Text(
                'GETTİR',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  labelText: 'Username',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                obscureText: true,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_usernameController.text == 'admin' && _passwordController.text == 'admin') {
                    // Navigate to AdminPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  } else {
                    // Handle login for non-admin users
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Login', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to RegisterScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Register', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
