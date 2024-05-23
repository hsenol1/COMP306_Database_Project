import 'dart:convert';

class Product {
  final String image;
  final String name;
  final double price;

  Product({required this.image, required this.name, required this.price});

  static List<Product> fromJsonList(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Product> productList = List.empty(growable: true);
    for (int i = 0; i < jsonList.length; i++) {
      List<dynamic> productString = jsonList[i];
      //int id = int.parse(productString[0]);
      //int stock = int.parse(productString[1]);
      double tmpPrice = double.parse(productString[3]);
      String tmpName = productString[4];
      productList.add(Product(
          image: 'assets/bunch-bananas-isolated-on-white-600w-1722111529.png',
          name: tmpName,
          price: tmpPrice));
    }
    return productList;
  }
}
