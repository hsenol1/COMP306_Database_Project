import 'package:flutter/material.dart';
import 'product_details_page.dart'; // Import the ProductDetailsPage

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Placeholder image
      'name': 'Product 1',
      'stock': 50,
      'price': 20.0,
      'category': 'Category A',
    },
    {
      'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Placeholder image
      'name': 'Product 2',
      'stock': 30,
      'price': 15.0,
      'category': 'Category B',
    },
    {
      'image': 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png', // Placeholder image
      'name': 'Product 3',
      'stock': 10,
      'price': 5.0,
      'category': 'Category A',
    },
    // Add more placeholder products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Show products with +3 rating
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Show products with 3+ rating', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Show lowest rated products of each category
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Lowest rated products', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Show 50 products with the lowest stock amount
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Low stock products', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)),
                      );
                    },
                    child: Card(
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
                                fit: BoxFit.cover, // Stretch the image to fill the container
                              ),
                            ),
                            SizedBox(width: 10), // Spacing between image and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product['name'], style: TextStyle(fontSize: 16, color: Colors.black)),
                                  SizedBox(height: 5),
                                  Text('Stock: ${product['stock']}', style: TextStyle(fontSize: 14, color: Colors.black)),
                                  SizedBox(height: 5),
                                  Text('Price: \$${product['price']}', style: TextStyle(fontSize: 14, color: Colors.black)),
                                  SizedBox(height: 5),
                                  Text('Category: ${product['category']}', style: TextStyle(fontSize: 14, color: Colors.black)),
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
