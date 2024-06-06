import 'package:delivery_frontend/models/user.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  // Mock user data
  final User user;
  final String name = 'John';
  final String surname = 'Doe';
  final String username = 'john_doe';
  final String password = 'password123';
  final String city = 'New York';
  final String address = '123 Main St';
  final String phoneNumber = '123-456-7890';
  ProfileScreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Surname: ${user.surname}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Username: ${user.username}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Password: ${user.pwd}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('City: $city',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Address: ${user.customerInfo.address}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Phone Number: ${user.customerInfo.phone}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderHistoryScreen(uid: user.id)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text('Order History',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text('Logout',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
