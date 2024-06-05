import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/basket.dart';
import '../models/product.dart';
import '../widgets/order_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  final List<Order> mockOrders = [
    Order(
      date: '2023-12-01',
      status: 'Completed',
      orderMethod: 'Online',
      voucher: 'Black Friday',
      basket: Basket()
        ..addItem(Product(name: 'Bananas', price: 1.99, image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png'), 2)
        ..addItem(Product(name: 'Apples', price: 2.49, image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png'), 3),
    ),
    Order(
      date: '2023-11-15',
      status: 'Pending',
      orderMethod: 'In-Store',
      voucher: null,
      basket: Basket()
        ..addItem(Product(name: 'Grapes', price: 4.99, image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png'), 1)
        ..addItem(Product(name: 'Mangoes', price: 5.99, image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png'), 2),
    ),
    Order(
      date: '2023-10-30',
      status: 'Cancelled',
      orderMethod: 'Online',
      voucher: 'Summer Sale',
      basket: Basket()
        ..addItem(Product(name: 'Pineapples', price: 6.99, image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png'), 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mockOrders.length,
          itemBuilder: (context, index) {
            return OrderCard(order: mockOrders[index]);
          },
        ),
      ),
    );
  }
}
