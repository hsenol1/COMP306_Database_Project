import 'dart:convert';

import 'package:delivery_frontend/services/network_service.dart';
import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import '../models/basket.dart';
import '../models/voucher.dart';
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
  int _selectedVoucherId = -1;
  final List<String> _paymentMethods = ['Card', 'Cash'];
  List<Voucher> _vouchers = [];
  double _discountedTotalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchVouchers();
    _updateTotalPrice();
  }

  Future<void> _fetchVouchers() async {
    final response =
        await widget.networkService.getVouchersByUid(widget.basket.uid);
    if (response.statusCode == 200) {
      final List<dynamic> voucherJson = jsonDecode(response.body);
      setState(() {
        _vouchers = voucherJson.map((json) {
          return Voucher(
            v_id: json[1],
            name: json[3],
            discountRate: json[2].toDouble(),
            amount: json[0],
          );
        }).toList();
      });
    } else {
      // Handle error
      showErrorPopup(context, "Network error");
    }
  }

  void _updateTotalPrice() {
    double discountRate = 0.0;
    if (_selectedVoucher != 'None') {
      Voucher? selectedVoucher = _vouchers.firstWhere(
          (voucher) => voucher.name == _selectedVoucher,
          orElse: () =>
              Voucher(v_id: -1, name: 'None', discountRate: 0.0, amount: 0));
      discountRate = selectedVoucher.discountRate;
      _selectedVoucherId = selectedVoucher.v_id;
    } else {
      _selectedVoucherId = -1;
    }
    setState(() {
      _discountedTotalPrice =
          widget.basket.totalPrice * ((100 - discountRate) / 100);
    });
  }

  List<DropdownMenuItem<String>> _buildVoucherDropdownItems() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem<String>(
        value: 'None',
        child: Text('None'),
      ),
    ];
    for (var voucher in _vouchers) {
      items.add(
        DropdownMenuItem<String>(
          value: voucher.name,
          child: Text('${voucher.name} - ${voucher.discountRate}%'),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final response =
                  await widget.networkService.deleteBasket(widget.basket.uid);
              if (response.statusCode == 200 || response.statusCode == 201) {
                widget.basket.clear();
                Navigator.pop(context);
              } else {
                showErrorPopup(context, "Network Error");
              }
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
                    Text('Total: \$${_discountedTotalPrice.toStringAsFixed(2)}',
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
                          _updateTotalPrice();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Voucher',
                        border: OutlineInputBorder(),
                      ),
                      items: _buildVoucherDropdownItems(),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final response =
                            await widget.networkService.completeOrder(
                          widget.basket.uid,
                          _selectedPaymentMethod,
                          _selectedVoucherId,
                        );
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          widget.basket.clear();
                          Navigator.pop(context);
                        } else if (response.statusCode == 408) {
                          showErrorPopup(context, "Not enough stock");
                        } else if (response.statusCode == 407) {
                          showErrorPopup(context,
                              "Total price should be greater than 100 TL.");
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
