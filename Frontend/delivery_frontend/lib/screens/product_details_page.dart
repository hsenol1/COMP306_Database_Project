import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'], style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(product['image'], width: double.infinity, height: 200, fit: BoxFit.cover),
              SizedBox(height: 20),
              Text('Name: ${product['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Stock: ${product['stock']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Price: \$${product['price']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              Text('Category: ${product['category']}', style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showChangeAmountDialog(context, 'Increase Amount', 'Amount:');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Increase Amount', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showChangeAmountDialog(context, 'Decrease Amount', 'Amount:');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Decrease Amount', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Delete Product', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangeAmountDialog(BuildContext context, String title, String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _amountController = TextEditingController();
        return AlertDialog(
          title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
          content: TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: label, labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle amount change logic
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product', style: TextStyle(fontSize: 16, color: Colors.black)),
          content: Text('Are you sure you want to delete this product?', style: TextStyle(fontSize: 16, color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle delete product logic
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}
