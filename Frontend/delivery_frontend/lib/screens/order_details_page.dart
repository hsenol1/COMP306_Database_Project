import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order['orderId']}', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Status: ${order['status']}', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Date: ${order['date']}', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Total Price: \$${order['totalPrice']}', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Payment Type: ${order['paymentType']}', style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Text('Products:', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order['products'].length,
                itemBuilder: (context, index) {
                  final product = order['products'][index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100, // Set the desired width
                            height: 100, // Set the desired height
                            child: Image.asset(
                              product['image'],
                              fit: BoxFit.cover, // Ensure the image covers the entire space
                            ),
                          ),
                          SizedBox(width: 10), // Spacing between image and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Product: ${product['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                Text('Amount: ${product['amount']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                Text('Price: \$${product['price']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
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
