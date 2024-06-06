import 'dart:convert';

import 'package:delivery_frontend/services/network_service.dart';
import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/basket.dart';
import '../models/product.dart';
import '../widgets/order_card.dart';

class OrderHistoryScreen extends StatefulWidget {
  final int uid;
  final NetworkService networkService = NetworkService();
  OrderHistoryScreen({required this.uid});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<List<Order>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = _initializeOrders();
  }

  Future<List<Order>> parseOrders(String jsonString) async {
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse.map((orderJson) => Order.fromJson(orderJson)).toList();
  }

  Future<List<Order>> _initializeOrders() async {
    final response = await widget.networkService.getOrderHistory(widget.uid);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return await parseOrders(response.body);
    } else {
      showErrorPopup(context, "Network Error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: snapshot.data![index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
