import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  final weatherIcon;
  final temp;
  final message;
  final city;

  const TextDisplay({
    Key key,
    @required this.weatherIcon,
    @required this.temp,
    @required this.message,
    @required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                Text(
                  '$temp°',
                  style: kTempTextStyle,
                ),
                Text(
                  '$weatherIcon',
                  style: kConditionTextStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Text(
              "$message in $city",
              textAlign: TextAlign.right,
              style: kMessageTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
