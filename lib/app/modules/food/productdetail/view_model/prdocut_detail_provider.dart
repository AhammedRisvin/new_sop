import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  bool isWishLIst = false;
  void isWishlistFnc() {
    isWishLIst = !isWishLIst;
    notifyListeners();
  }

  int count = 0;
  countIncrement() {
    count++;
    notifyListeners();
  }

  countDecreament() {
    count--;
    notifyListeners();
  }
}
