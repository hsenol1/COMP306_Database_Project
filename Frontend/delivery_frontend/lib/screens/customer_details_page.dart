import 'package:flutter/material.dart';
import 'package:delivery_frontend/services/network_service.dart'; // Import your network service

class CustomerDetailsPage extends StatelessWidget {
  final Map<String, dynamic> customer;
  final NetworkService networkService = NetworkService(); // Create an instance of NetworkService

  CustomerDetailsPage({required this.customer});

  void _deleteCustomer(BuildContext context) async {
    await networkService.deleteCustomer(customer['id'].toString());
    Navigator.of(context).pop(true); // Return true to indicate the customer was deleted
    Navigator.of(context).pop(true); // Return true to indicate the customer was deleted
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(customer['username'].toString(), style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username: ${customer['username']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Name: ${customer['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Surname: ${customer['surname']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('City: ${customer['city']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Address: ${customer['home_address']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Phone: ${customer['phone'].toString()}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(context);
                    },
                    child: Text('Delete Account', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account', style: TextStyle(fontSize: 16, color: Colors.black)),
          content: Text('Are you sure you want to delete this account?', style: TextStyle(fontSize: 16, color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteCustomer(context);
              },
              child: Text('OK', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
}
