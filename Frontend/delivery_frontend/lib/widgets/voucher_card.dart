import 'package:flutter/material.dart';
import '../models/voucher.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  VoucherCard({required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voucher.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Discount Rate: ${voucher.discountRate.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Amount: ${voucher.amount}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
