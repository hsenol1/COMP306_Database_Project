import 'package:flutter/material.dart';
import 'package:delivery_frontend/services/network_service.dart'; // Import your network service

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Map<String, dynamic> product;
  final NetworkService networkService = NetworkService(); // Create an instance of NetworkService
  bool _isProductUpdated = false; // Flag to check if product was updated

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  void _updateStock(int quantity) async {
    await networkService.increaseProductQuantity(product['id'].toString(), quantity);
    setState(() {
      product['stock'] += quantity;
      _isProductUpdated = true; // Set flag to true
    });
  }

  void _decreaseStock(int quantity) async {
    await networkService.decreaseProductQuantity(product['id'].toString(), quantity);
    setState(() {
      product['stock'] -= quantity;
      _isProductUpdated = true; // Set flag to true
    });
  }

  void _deleteProduct() async {
    await networkService.deleteTemplate('delete-product', product['id'].toString());
    setState(() {
      _isProductUpdated = true; // Set flag to true
    });
    Navigator.of(context).pop(true); // Return true to indicate the product was deleted
    Navigator.of(context).pop(true);
  }

  void _showChangeAmountDialog(BuildContext context, String title, String label, bool isIncrease) {
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
              onPressed: () async {
                int quantity = int.tryParse(_amountController.text) ?? 0;
                if (quantity > 0) {
                  if (isIncrease) {
                    _updateStock(quantity);
                  } else {
                    _decreaseStock(quantity);
                  }
                  Navigator.of(context).pop();
                } else {
                  // Show error message for invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid quantity')),
                  );
                }
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
                _deleteProduct();
              },
              child: Text('OK', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(_isProductUpdated);
        return false;
      },
      child: Scaffold(
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
                    _showChangeAmountDialog(context, 'Increase Amount', 'Amount:', true);
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
                    _showChangeAmountDialog(context, 'Decrease Amount', 'Amount:', false);
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
      ),
    );
  }
}
