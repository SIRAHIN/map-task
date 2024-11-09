import 'package:flutter/material.dart';

TextStyle headinTextStyle(
    {required double fontSize,
    required Color fontColor,
    required bool isTextBold}) {
  return TextStyle(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: isTextBold ? FontWeight.bold : FontWeight.w500);
}

TextStyle bodyTextStyle(
    {required double fontSize,
    required Color fontColor,
    required bool isTextBold}) {
  return TextStyle(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: isTextBold ? FontWeight.bold : FontWeight.w500);
}
