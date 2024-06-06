import 'package:delivery_frontend/services/network_service.dart';
import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/basket.dart';
import '../utils/dialog_utils.dart';

class BasketScreen extends StatefulWidget {
  final Basket basket;
  final NetworkService networkService = NetworkService();
  BasketScreen({required this.basket});

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  String _selectedPaymentMethod = 'Card';
  String _selectedVoucher = 'None';
  final List<String> _paymentMethods = ['Card', 'Cash'];
  final List<String> _vouchers = [
    'None',
    'Voucher 1',
    'Voucher 2',
    'Voucher 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              //showLoadingDialog(context);

              //await Future.delayed(Duration(seconds: 3));
              widget.basket.clear();
              //Navigator.of(context).pop();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<BasketItem>>(
        valueListenable: widget.basket.itemsNotifier,
        builder: (context, items, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.asset(item.product.image,
                          width: 50, height: 50),
                      title: Text(item.product.name,
                          style: TextStyle(fontSize: 16)),
                      subtitle: Text('Count: ${item.count}',
                          style: TextStyle(fontSize: 16)),
                      trailing: Text(
                          '\$${(item.product.price * item.count).toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        'Total: \$${widget.basket.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedPaymentMethod,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPaymentMethod = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Payment Method',
                        border: OutlineInputBorder(),
                      ),
                      items: _paymentMethods
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedVoucher,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedVoucher = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Voucher',
                        border: OutlineInputBorder(),
                      ),
                      items: _vouchers
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final response = await widget.networkService
                            .completeOrder(
                                widget.basket.uid, _selectedPaymentMethod, -1);
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          widget.basket.clear();

                          Navigator.pop(context);
                        } else {
                          showErrorPopup(context, "Network Error");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
