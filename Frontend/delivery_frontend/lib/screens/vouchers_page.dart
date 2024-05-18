import 'package:flutter/material.dart';

class VouchersPage extends StatelessWidget {
  final List<Map<String, dynamic>> vouchers = [
    {
      'voucherId': 'V001',
      'discountRate': 10,
      'name': 'Summer Sale',
    },
    {
      'voucherId': 'V002',
      'discountRate': 20,
      'name': 'Black Friday',
    },
    {
      'voucherId': 'V003',
      'discountRate': 15,
      'name': 'New Year',
    },
    // Add more placeholder vouchers as needed
  ];

  void _showDeleteConfirmationDialog(BuildContext context, String voucherId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Voucher', style: TextStyle(fontSize: 24)),
          content: Text('Are you sure you want to delete this voucher?', style: TextStyle(fontSize: 16, color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle delete voucher logic here
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontSize: 16, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vouchers', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Add voucher logic (to be implemented)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Add Voucher', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 10), // Add spacing between button and list
            Expanded(
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Voucher ID: ${voucher['voucherId']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                Text('Discount Rate: ${voucher['discountRate']}%', style: TextStyle(fontSize: 16, color: Colors.black)),
                                Text('Name: ${voucher['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, voucher['voucherId']);
                            },
                            child: Text('Delete', style: TextStyle(fontSize: 16, color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
