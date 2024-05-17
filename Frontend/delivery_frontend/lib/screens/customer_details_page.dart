import 'package:flutter/material.dart';


class CustomerDetailsPage extends StatelessWidget {
  final Map<String, dynamic> customer;

  CustomerDetailsPage({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(customer['username'], style: TextStyle(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${customer['username']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Text('Name: ${customer['name']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Text('Surname: ${customer['surname']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Text('Password: ${customer['password']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Text('City: ${customer['city']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Text('Address: ${customer['address']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Text('Phone: ${customer['phone']}', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  child: Text('Delete Account', style: TextStyle(fontSize: 40)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account', style: TextStyle(fontSize: 40)),
          content: Text('Are you sure you want to delete this account?', style: TextStyle(fontSize: 40)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 40)),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle delete account logic here
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontSize: 40)),
            ),
          ],
        );
      },
    );
  }
}
