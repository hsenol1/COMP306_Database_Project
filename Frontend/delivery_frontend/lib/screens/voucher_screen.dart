import 'dart:convert';

import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import '../models/voucher.dart';
import '../widgets/voucher_card.dart';
import '../services/network_service.dart'; // Import your network service

class VoucherScreen extends StatefulWidget {
  final int uid;
  final NetworkService networkService = NetworkService();
  VoucherScreen({required this.uid});

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  List<Voucher> vouchers = [];

  @override
  void initState() {
    super.initState();
    _fetchVouchers();
  }

  Future<void> _fetchVouchers() async {
    final response = await widget.networkService.getVouchersByUid(widget.uid);
    if (response.statusCode == 200) {
      final List<dynamic> voucherJson = jsonDecode(response.body);
      setState(() {
        vouchers = voucherJson.map((json) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: vouchers.isEmpty
            ? Center(
                child: Text(
                  'No vouchers available',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  return VoucherCard(voucher: vouchers[index]);
                },
              ),
      ),
    );
  }
}
