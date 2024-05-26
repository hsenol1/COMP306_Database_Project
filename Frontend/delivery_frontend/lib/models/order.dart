import 'basket.dart';

class Order {
  final String date;
  final String status;
  final String orderMethod;
  final String? voucher;
  final Basket basket;

  Order({
    required this.date,
    required this.status,
    required this.orderMethod,
    this.voucher,
    required this.basket,
  });

  double get totalPrice => basket.totalPrice;
}
