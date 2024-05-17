import 'package:flutter/material.dart';
import 'products_page.dart'; // Import the ProductsPage
import 'customers_page.dart'; // Import the CustomersPage
import 'orders_page.dart'; // Import the OrdersPage
import 'vouchers_page.dart'; // Import the VouchersPage

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontSize: 24)),
      ),
      body: Padding(
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
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                child: Text('Products', style: TextStyle(fontSize: 70)),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigate to Customers page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomersPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                child: Text('Customers', style: TextStyle(fontSize: 70)),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigate to Orders page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                child: Text('Orders', style: TextStyle(fontSize: 70)),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigate to Orders page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VouchersPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                child: Text('Vouchers', style: TextStyle(fontSize: 70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
