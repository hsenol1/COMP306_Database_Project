import 'package:flutter/material.dart';
import 'customer_details_page.dart';
import 'package:delivery_frontend/services/network_service.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final NetworkService networkService = NetworkService();
  List<Map<String, dynamic>> customers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedCustomers = await networkService.fetchCustomers();
      setState(() {
        customers = fetchedCustomers;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchOneCustomerPerCity() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedCustomers = await networkService.fetchOneCustomerPerCity();
      setState(() {
        customers = fetchedCustomers;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> navigateToCustomerDetails(Map<String, dynamic> customer) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerDetailsPage(customer: customer)),
    );
    if (result == true) {
      fetchCustomers(); // Refresh the customer list if a customer was deleted
    }
  }

  void _showGiveVoucherDialog(BuildContext context) {
    final _voucherIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Give Vouchers to Customers', style: TextStyle(fontSize: 24)),
          content: TextField(
            controller: _voucherIdController,
            decoration: InputDecoration(labelText: 'Voucher ID'),
            keyboardType: TextInputType.number,
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
                String voucherId = _voucherIdController.text;
                giveVouchersToNCustomerPerCity(voucherId);
                Navigator.of(context).pop();
              },
              child: Text('Give Vouchers', style: TextStyle(fontSize: 16, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> giveVouchersToNCustomerPerCity(String voucherId) async {
    try {
      await networkService.giveVoucherToOneCustomerPerCity(voucherId);
      fetchCustomers(); // Refresh the list after giving vouchers
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fetchOneCustomerPerCity();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Show one customer per city', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showGiveVoucherDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Give Vouchers', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20), // Add spacing between button and list
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        final customer = customers[index];
                        return GestureDetector(
                          onTap: () {
                            navigateToCustomerDetails(customer);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Username: ${customer['username']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                        Text('Name: ${customer['name']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                        Text('Surname: ${customer['surname']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                        Text('Phone: ${customer['phone']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
