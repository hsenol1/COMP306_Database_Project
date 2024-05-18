import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/basket.dart';
import '../widgets/product_card.dart'; // Import the ProductCard

class HomeContent extends StatelessWidget {
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

  final Basket basket;

  HomeContent({required this.basket});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                CategoryButton(name: 'Category 1'),
                CategoryButton(name: 'Category 2'),
                CategoryButton(name: 'Category 3'),
                CategoryButton(name: 'Category 4'),
              ],
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
                return ProductCard(product: product, basket: basket);
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

  CategoryButton({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle category button press
        },
        child: Text(name),
      ),
    );
  }
}
