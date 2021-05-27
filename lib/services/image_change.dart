import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageChange extends ValueNotifier<AssetImage> {
  ImageChange(AssetImage value) : super(value);
  void imageChange(AssetImage img) {
    value = img;
    notifyListeners();
  }
}

var backgroundImage = ImageChange(AssetImage('images/blank.jpeg'));
