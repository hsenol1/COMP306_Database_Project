import 'basket.dart';

class Order {
  final int o_id;
  final String date;
  final String status;
  final String orderMethod;
  final String? voucher;
  final Basket basket;
  int rating;

  Order(
      {required this.o_id,
      required this.date,
      required this.status,
      required this.orderMethod,
      this.voucher,
      required this.basket,
      required this.rating});

  factory Order.fromJson(List<dynamic> json) {
    return Order(
      o_id: json[0] as int,
      date: json[3] as String,
      status: json[4] as String,
      orderMethod: json[1] as String,
      rating: json[6],
      voucher: json[5] as String?,
      basket: Basket.fromJson(json[7]),
    );
  }

  double get totalPrice => basket.totalPrice;
}
