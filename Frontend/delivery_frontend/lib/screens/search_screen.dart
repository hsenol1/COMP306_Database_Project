import 'package:delivery_frontend/services/network_service.dart';
import 'package:delivery_frontend/utils/dialog_utils.dart';
import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/basket.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  final Basket basket;
  SearchScreen({required this.basket});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Product> products = [
    Product(
      image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
      name: 'Bananas',
      price: 1.99,
    ),
    Product(
      image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
      name: 'Apples',
      price: 2.49,
    ),
    Product(
      image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
      name: 'Oranges',
      price: 3.99,
    ),
    Product(
      image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
      name: 'Grapes',
      price: 4.99,
    ),
    Product(
      image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
      name: 'Mangoes',
      price: 5.99,
    ),
    Product(
      image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
      name: 'Pineapples',
      price: 6.99,
    ),
  ];

  late Basket _basket;
  bool isLoading = true;
  final NetworkService _networkService =
      NetworkService(baseUrl: 'http://10.0.2.2:8000');

  String query = '';
  List<Product> filteredProducts = [];

  void _searchProducts() {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _basket = widget.basket;
    filteredProducts = products;
  }

  void updateProducts(List<Product> newProducts) {
    setState(() {
      filteredProducts = newProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      query = value;
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    //GETTIRTODO: Until backend fixes structure of get queries.

                    showLoadingDialog(context);
                    await Future.delayed(Duration(seconds: 3));
                    List<Product> products = Product.fromJsonList(
                        '[[1, 100, "food", "3.50", "bread"]]');
                    updateProducts(products);
                    Navigator.of(context).pop();
                    return;

                    final response =
                        await _networkService.getProductsBySearch(query);
                    if (response.statusCode == 200) {
                      List<Product> products =
                          Product.fromJsonList(response.body);
                      updateProducts(products);
                    } else if (response.statusCode == 404) {
                      showErrorPopup(context, response.body);
                    } else {
                      showErrorPopup(
                          context, 'Network error occurred. Please try again.');
                    }
                  },
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(product: product, basket: _basket);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
