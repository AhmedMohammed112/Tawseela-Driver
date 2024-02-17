
import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required Color color,
  required FontWeight? fontWeight,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontManager.fontFamily,
  );
}

// Bold Text
TextStyle boldText({
  double fontSize = FontSizes.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color:color,
    fontWeight:FontWeights.bold,
  );
}

// Semi Bold Text
TextStyle semiBoldText({
  double fontSize = FontSizes.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color:color,
    fontWeight:FontWeights.bold,
  );
}

// Medium Text
TextStyle mediumText({
  double fontSize = FontSizes.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color:color,
    fontWeight:FontWeights.medium,
  );
}

// Regular Text
TextStyle regularText({
  double fontSize = FontSizes.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color:color,
    fontWeight:FontWeights.regular,
  );
}

// Light Text
TextStyle lightText({
  double fontSize = FontSizes.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color:color,
    fontWeight:FontWeights.light,
  );
}

