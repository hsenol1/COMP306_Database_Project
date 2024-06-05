import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  // Mock user data
  final String name = 'John';
  final String surname = 'Doe';
  final String username = 'john_doe';
  final String password = 'password123';
  final String city = 'New York';
  final String address = '123 Main St';
  final String phoneNumber = '123-456-7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Surname: $surname', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Username: $username', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Password: $password', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('City: $city', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Address: $address', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Phone Number: $phoneNumber', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text('Order History', style: TextStyle(fontSize: 16, color: Colors.white)),
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
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text('Logout', style: TextStyle(fontSize: 16, color: Colors.white)),
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
