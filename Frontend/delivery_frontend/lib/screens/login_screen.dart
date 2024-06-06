import 'dart:convert';

import 'package:delivery_frontend/models/user.dart';
import 'package:delivery_frontend/models/user_info.dart';
import 'package:delivery_frontend/screens/main_screen.dart';
import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'admin_page.dart';
import 'package:delivery_frontend/services/network_service.dart';

class LoginScreen extends StatelessWidget {
  final NetworkService _networkService = NetworkService();
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
              SizedBox(height: 30),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                obscureText: true,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final response = await _networkService.login(
                      _usernameController.text, _passwordController.text);
                  if (response.statusCode == 200) {
                    List<dynamic> jsonData = jsonDecode(response.body);
                    User _user = User.fromJson(jsonData);
                    if (_user.isAdmin) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminPage()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              user: _user,
                            ),
                          ));
                    }
                  } else if (response.statusCode == 401) {
                    showErrorPopup(context, response.body);
                  } else {
                    showErrorPopup(
                        context, "Network error occured. Please try again.");
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
