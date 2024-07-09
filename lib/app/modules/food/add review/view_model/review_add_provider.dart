import 'package:flutter/material.dart';

class ReviewAddProvider extends ChangeNotifier {
  List reviewsList = [
    'Location awareness',
    'Rider behavior',
    'Rider hygiene',
    'Excessive calling',
    'Delivery time',
    'Spilled or damged item',
    'Delivery instruction ignored',
  ];

  double ratinglenght = 0.0;

  ratingLengthFun({double? value}) {
    ratinglenght = value ?? 0.0;
    notifyListeners();

    // String ratingComments = '';
    // ratingCommentsFn({String? value}) {
    //   ratingComments = value ?? '';
    //   notifyListeners();
    // }
  }
}
