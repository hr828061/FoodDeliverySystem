
import 'package:ecommerce/models/product.dart';

class Cart {
  static final Cart _singleton = Cart._internal();

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

  List<Product> _products = [];

  void addProduct(Product product, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _products.add(product);
    }
  }

  List<Product> get products => _products;
}
