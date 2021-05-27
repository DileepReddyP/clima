import 'package:clima/services/image_change.dart';
import 'package:clima/utilities/background_images.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatefulWidget {
  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('images/blank.jpeg'), context);
    for (AssetImage imagex in images.values) {
      precacheImage(imagex, context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AssetImage>(
      valueListenable: backgroundImage,
      builder: (context, value, child) {
        return Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: value,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
