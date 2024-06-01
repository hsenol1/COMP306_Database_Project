import 'package:flutter/material.dart';
import 'product_details_page.dart';
import 'package:delivery_frontend/services/network_service.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final NetworkService networkService = NetworkService();
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetch(Future<List<Map<String, dynamic>>> Function() fetchFunction) async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedProducts = await fetchFunction();
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

  Future<void> fetchProducts() async {
    await fetch(networkService.fetchProducts);
  }

  Future<void> fetchLowStockProducts() async {
    await fetch(networkService.fetchLowStockProducts);
  }

  Future<void> fetchProductsWithHigherThan4Rating() async {
    await fetch(networkService.fetchProductsWithHigherthan4Rating);
  }

  Future<void> fetchTop5LowestRatedProducts() async {
    await fetch(networkService.fetchTop5LowestRatedProducts);
  }

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
                    fetchProductsWithHigherThan4Rating();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Show products with 4+ rating', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    fetchTop5LowestRatedProducts();
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
                    fetchLowStockProducts();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Lowest stock product from every category', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        print(product); // Debugging: Print each product
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
                                    child: Image.network(
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