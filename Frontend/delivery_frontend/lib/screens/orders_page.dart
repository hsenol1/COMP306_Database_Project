import 'package:flutter/material.dart';
import 'order_details_page.dart'; // Import the OrderDetailsPage

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': '1001',
      'status': 'Pending',
      'date': '2024-01-01',
      'totalPrice': 100.0,
      'paymentType': 'Credit Card',
      'products': [
        {
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Asset image path
          'name': 'Product 1',
          'amount': 2,
          'price': 20.0,
        },
        {
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Asset image path
          'name': 'Product 2',
          'amount': 1,
          'price': 60.0,
        },
      ],
    },
    {
      'orderId': '1002',
      'status': 'Completed',
      'date': '2024-01-02',
      'totalPrice': 200.0,
      'paymentType': 'PayPal',
      'products': [
        {
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Asset image path
          'name': 'Product 3',
          'amount': 3,
          'price': 40.0,
        },
        {
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Asset image path
          'name': 'Product 2',
          'amount': 2,
          'price': 40.0,
        },
      ],
    },
    {
      'orderId': '1003',
      'status': 'Cancelled',
      'date': '2024-01-03',
      'totalPrice': 150.0,
      'paymentType': 'Debit Card',
      'products': [
        {
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Asset image path
          'name': 'Product 1',
          'amount': 5,
          'price': 30.0,
        },
        {
          'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Asset image path
          'name': 'Product 3',
          'amount': 2,
          'price': 60.0,
        },
      ],
    },
    // Add more placeholder orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsPage(order: order)),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID: ${order['orderId']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text('Status: ${order['status']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text('Date: ${order['date']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text('Total Price: \$${order['totalPrice']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
