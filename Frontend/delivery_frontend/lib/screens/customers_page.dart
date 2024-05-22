import 'package:flutter/material.dart';
import 'customer_details_page.dart';

class CustomersPage extends StatelessWidget {
  final List<Map<String, dynamic>> customers = [
    {
      'username': 'user1',
      'name': 'John',
      'surname': 'Doe',
      'phone': '123-456-7890',
      'city': 'City A',
      'address': '123 Main St',
      'password': 'password1',
    },
    {
      'username': 'user2',
      'name': 'Jane',
      'surname': 'Smith',
      'phone': '234-567-8901',
      'city': 'City B',
      'address': '456 Elm St',
      'password': 'password2',
    },
    {
      'username': 'user3',
      'name': 'Bob',
      'surname': 'Johnson',
      'phone': '345-678-9012',
      'city': 'City A',
      'address': '789 Oak St',
      'password': 'password3',
    },
    // Add more placeholder customers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Show one customer per city logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Show one customer per city', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20), // Add spacing between button and list
            Expanded(
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerDetailsPage(customer: customer)),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Username: ${customer['username']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                  Text('Name: ${customer['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                  Text('Surname: ${customer['surname']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                  Text('Phone: ${customer['phone']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
