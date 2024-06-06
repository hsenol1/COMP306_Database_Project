import 'dart:convert';

import 'package:delivery_frontend/screens/products_page.dart';

class Product {
  final String image;
  final String name;
  final double price;
  final int id;

  Product(
      {required this.image,
      required this.name,
      required this.price,
      required this.id});

  static List<Product> fromJsonList(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Product> productList = List.empty(growable: true);
    for (int i = 0; i < jsonList.length; i++) {
      List<dynamic> productString = jsonList[i];
      int id = productString[0];
      //int stock = int.parse(productString[1]);
      double tmpPrice = double.parse(productString[3]);
      String tmpName = productString[4];
      productList.add(Product(
          image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
          name: tmpName,
          price: tmpPrice,
          id: id));
    }
    return productList;
  }

  factory Product.fromJson(List<dynamic> json) {
    return Product(
        id: json[1] as int,
        name: json[0] as String,
        price: double.parse(json[4] as String),
        image: "assets/${json[0] as String}.png");
  }
}
