import 'package:flutter/material.dart';
import 'package:delivery_frontend/services/network_service.dart';

class VouchersPage extends StatefulWidget {
  @override
  _VouchersPageState createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  final NetworkService networkService = NetworkService();
  List<Map<String, dynamic>> vouchers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVouchers();
  }

  Future<void> fetchVouchers() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedVouchers = await networkService.fetchVouchers();
      setState(() {
        vouchers = fetchedVouchers;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteVoucher(String voucherId) async {
    try {
      await networkService.deleteVoucher(voucherId);
      fetchVouchers(); // Refresh the list after deletion
    } catch (e) {
      print(e);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int voucherId) {
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
                deleteVoucher(voucherId.toString());
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

  void _showAddVoucherDialog(BuildContext context) {
    final _discountRateController = TextEditingController();
    final _voucherNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Voucher', style: TextStyle(fontSize: 24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _discountRateController,
                decoration: InputDecoration(labelText: 'Discount Rate'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _voucherNameController,
                decoration: InputDecoration(labelText: 'Voucher Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                int discountRate = int.parse(_discountRateController.text);
                String voucherName = _voucherNameController.text;
                addVoucher(discountRate, voucherName);
                Navigator.of(context).pop();
              },
              child: Text('Add', style: TextStyle(fontSize: 16, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> addVoucher(int discountRate, String voucherName) async {
    try {
      await networkService.insertVoucher(discountRate, voucherName);
      fetchVouchers(); // Refresh the list after adding a new voucher
    } catch (e) {
      print(e);
    }
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
                _showAddVoucherDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Add Voucher', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 10), // Add spacing between button and list
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
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
                                      Text('Voucher ID: ${voucher['id']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                      Text('Discount Rate: ${voucher['discount_rate']}%', style: TextStyle(fontSize: 16, color: Colors.black)),
                                      Text('Name: ${voucher['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(context, voucher['id']);
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
