import 'package:flutter/material.dart';
import 'package:delivery_frontend/services/network_service.dart'; // Import your network service

class OrderDetailsPage extends StatefulWidget {
  final Map<String, dynamic> order;

  OrderDetailsPage({required this.order});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final NetworkService networkService = NetworkService(); // Create an instance of NetworkService
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedProducts = await networkService.fetchProductsFromOrder(widget.order['id'].toString());
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${widget.order['id']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                  SizedBox(height: 10),
                  Text('Customer ID: ${widget.order['customer_id']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                  SizedBox(height: 10),
                  Text('Date: ${widget.order['date']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                  SizedBox(height: 10),
                  Text('Total Price: \$${widget.order['total_price']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                  SizedBox(height: 10),
                  Text('Products:', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
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
                                      Text('Quantity: ${product['quantity']}', style: TextStyle(fontSize: 16, color: Colors.black)),
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
