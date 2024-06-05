import 'package:flutter/material.dart';
import 'order_details_page.dart';
import 'package:delivery_frontend/services/network_service.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final NetworkService networkService = NetworkService();
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedOrders = await networkService.fetchOrders();
      setState(() {
        orders = fetchedOrders;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> navigateToOrderDetails(Map<String, dynamic> order) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailsPage(order: order)),
    );
    if (result == true) {
      fetchOrders(); // Refresh the order list if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToOrderDetails(order);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order ID: ${order['id']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                            Text('Customer ID: ${order['customer_id']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                            Text('Date: ${order['date']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                            Text('Total Price: \$${order['total_price']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
