import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/basket.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Basket basket;

  ProductCard({required this.product, required this.basket});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BasketItem>>(
      valueListenable: basket.itemsNotifier,
      builder: (context, items, _) {
        int productCount = items
            .where((item) => item.product.name == product.name)
            .fold(0, (sum, item) => sum + item.count);

        return Card(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Column(
                  children: [
                    if (productCount > 0)
                      Text(
                        '$productCount',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        basket.addItem(product, 1);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
