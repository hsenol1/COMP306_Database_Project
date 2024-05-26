import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  void _showBasket(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basket Items',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: order.basket.items.length,
                  itemBuilder: (context, index) {
                    final item = order.basket.items[index];
                    return ListTile(
                      leading: Image.asset(item.product.image, width: 50, height: 50),
                      title: Text(item.product.name, style: TextStyle(fontSize: 16)),
                      subtitle: Text('Count: ${item.count}', style: TextStyle(fontSize: 16)),
                      trailing: Text('\$${(item.product.price * item.count).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Total: \$${order.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBasket(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${order.date}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Status: ${order.status}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Order Method: ${order.orderMethod}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              if (order.voucher != null)
                Text(
                  'Voucher: ${order.voucher}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 8),
              Text(
                'Total Price: \$${order.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
