// models/basket.dart

import 'package:flutter/foundation.dart';
import 'product.dart';

class Basket {
  final ValueNotifier<List<BasketItem>> _items = ValueNotifier<List<BasketItem>>([]);

  List<BasketItem> get items => _items.value;

  void addItem(Product product, int count) {
    List<BasketItem> newItems = List.from(_items.value);
    bool found = false;
    for (var item in newItems) {
      if (item.product.name == product.name) {
        item.count += count;
        found = true;
        break;
      }
    }
    if (!found) {
      newItems.add(BasketItem(product: product, count: count));
    }
    _items.value = newItems;
  }

  void clear() {
    _items.value = [];
  }

  double get totalPrice {
    return _items.value.fold(0, (total, item) => total + (item.product.price * item.count));
  }

  bool get isEmpty => _items.value.isEmpty;

  ValueNotifier<List<BasketItem>> get itemsNotifier => _items;
}

class BasketItem {
  final Product product;
  int count;

  BasketItem({required this.product, required this.count});
}
