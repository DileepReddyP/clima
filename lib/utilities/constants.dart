import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kAppFont = GoogleFonts.spartan(
  fontWeight: FontWeight.w900,
).fontFamily;

final kTempTextStyle = TextStyle(
  fontFamily: kAppFont,
  fontSize: 70.0,
);

final kMessageTextStyle = TextStyle(
  fontFamily: kAppFont,
  fontSize: 60.0,
);



final kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: kAppFont,
  color: Colors.white,
);

final kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

final kTextFieldDecoration = InputDecoration(
  filled: true,
  hintText: 'City',
  hintStyle: TextStyle(
    fontFamily: kAppFont,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(6.0),
    ),
    borderSide: BorderSide.none,
  ),
  // border: InputBorder.none,
  // focusedBorder: InputBorder.none,
  // enabledBorder: InputBorder.none,
  // errorBorder: InputBorder.none,
  // disabledBorder: InputBorder.none,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
);
