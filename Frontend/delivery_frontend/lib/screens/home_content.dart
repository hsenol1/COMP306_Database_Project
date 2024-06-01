import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/basket.dart';
import '../services/network_service.dart';
import '../widgets/product_card.dart';
import '../utils/popup_utils.dart';

class HomeContent extends StatefulWidget {
  final Basket basket;

  HomeContent({required this.basket});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Product> products = [
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

  List<String> categories = [];
  bool isLoading = true;
  final NetworkService _networkService =
      NetworkService();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final response = await _networkService.getCategories();
    if (response.statusCode == 200) {
      List<dynamic> decodedJson = jsonDecode(response.body);
      List<String> tmpCategories = List<String>.from(decodedJson);
      setState(() {
        categories = tmpCategories;
        isLoading = false;
      });
    } else if (response.statusCode == 404) {
      setState(() {
        isLoading = false;
      });
      showErrorPopup(context, response.body);
    } else {
      setState(() {
        isLoading = false;
      });
      showErrorPopup(context, "Network error occurred. Please try again.");
    }
  }

  void updateProducts(List<Product> newProducts) {
    setState(() {
      products = newProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: Colors.grey[200],
          padding: EdgeInsets.all(10.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map((category) => CategoryButton(
                              name: category,
                              networkService: _networkService,
                              onProductsFetched: updateProducts,
                            ))
                        .toList(),
                  ),
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
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product, basket: widget.basket);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String name;
  final NetworkService networkService;
  final Function(List<Product>) onProductsFetched;

  CategoryButton(
      {required this.name,
      required this.networkService,
      required this.onProductsFetched});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () async {
          //GETTIRTODO: Until backend fixes structure of get queries.
          List<Product> products =
              Product.fromJsonList('[[1, 100, "food", "3.50", "bread"]]');
          onProductsFetched(products);
          return;
          final response = await networkService.getProductsByCategory(name);
          if (response.statusCode == 200) {
            List<Product> products = Product.fromJsonList(response.body);
            onProductsFetched(products);
          } else if (response.statusCode == 404) {
            showErrorPopup(context, response.body);
          } else {
            showErrorPopup(
                context, 'Network error occurred. Please try again.');
          }
        },
        child: Text(name),
      ),
    );
  }
}
