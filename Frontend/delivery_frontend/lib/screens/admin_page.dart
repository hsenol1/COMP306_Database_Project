import 'package:flutter/material.dart';
import 'products_page.dart';
import 'customers_page.dart';
import 'orders_page.dart';
import 'vouchers_page.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Navigate to Products page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Products', style: TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Customers page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomersPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Customers', style: TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Orders page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Orders', style: TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Vouchers page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VouchersPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Vouchers', style: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
