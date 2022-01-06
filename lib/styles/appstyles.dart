import 'package:flutter/material.dart';

class AppStyle {


  static primaryTextStyleb() {
    return TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
  }


  static primaryTextStyleHeading() {
    return TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  }


  static primaryTextStylenormalBold() {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold);
  }

  static primaryTextStylenormal() {

    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.w400);
  }

  static primaryTextStylenormalBoldItalics() {

    return TextStyle(
        color: Colors.black,fontStyle: FontStyle.italic);

  }

}
