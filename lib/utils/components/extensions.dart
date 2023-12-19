import 'dart:math';

import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  Orientation orientation() => MediaQuery.of(this).orientation;
  double height([double percent = 1]) {
    return orientation() == Orientation.portrait
        ? MediaQuery.of(this).size.height * percent
        : MediaQuery.of(this).size.width * percent;
  }

  double width([double percent = 1]) {
    {
      return orientation() == Orientation.landscape
          ? MediaQuery.of(this).size.height * percent
          : MediaQuery.of(this).size.width * percent;
    }
  }
}

extension TruncateDoubles on num {
  double truncateToDecimalPlaces(int fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}