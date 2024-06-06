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

  factory Order.fromJson(List<dynamic> json) {
    return Order(
      date: json[3] as String,
      status: json[4] as String,
      orderMethod: json[1] as String,
      voucher: json[5] as String?,
      basket: Basket.fromJson(json[7]),
    );
  }

  double get totalPrice => basket.totalPrice;
}
