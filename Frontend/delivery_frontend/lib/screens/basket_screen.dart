import 'package:flutter/material.dart';
import '../models/basket.dart';

class BasketScreen extends StatelessWidget {
  final Basket basket;

  BasketScreen({required this.basket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              basket.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<BasketItem>>(
        valueListenable: basket.itemsNotifier,
        builder: (context, items, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
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
                child: Column(
                  children: [
                    Text('Total: \$${basket.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle buy action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      child: Text('Buy', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
