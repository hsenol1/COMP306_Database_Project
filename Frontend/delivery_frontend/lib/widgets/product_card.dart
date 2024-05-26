import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/basket.dart';
import 'dart:async';
import '../utils/dialog_utils.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Basket basket;

  ProductCard({required this.product, required this.basket});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isLoading = false;

  Future<void> _addItemToBasket() async {
    setState(() {
      _isLoading = true;
    });

    showLoadingDialog(context);

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop();

    widget.basket.addItem(widget.product, 1);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BasketItem>>(
      valueListenable: widget.basket.itemsNotifier,
      builder: (context, items, _) {
        int productCount = items
            .where((item) => item.product.name == widget.product.name)
            .fold(0, (sum, item) => sum + item.count);

        return Card(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      widget.product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
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
                      icon: _isLoading ? CircularProgressIndicator() : Icon(Icons.add),
                      onPressed: _isLoading ? null : _addItemToBasket,
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
