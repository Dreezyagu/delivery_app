import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ojembaa_mobile/utils/components/extensions.dart';

class Utility {
  static String currencyFormatter(num amount) {
    final truncatedAmount = amount.truncateToDecimalPlaces(2);
    final formatter = NumberFormat("###,##0.00", "en-ng");
    String formattedAmount = formatter.format(truncatedAmount);
    return formattedAmount;
  }

  static String normaliseISO8601Date(String date) {
    return date.replaceFirstMapped(RegExp("(\\.\\d{6})\\d+"), (m) => m[1]!);
  }

  static String convertDateToTime(DateTime date, {String format = ""}) {
    return DateFormat.jm().format(date.toLocal());
  }

  static num getExpectedCharge(String paymentFee, num? transactionFee) {
    num expectedFee = 0.0;
    num employerPercent = 0.0;
    if (paymentFee == "employee") {
      employerPercent = 0.0;
      expectedFee =
          transactionFee! - ((employerPercent / 100) * transactionFee);
    } else if (paymentFee == "employer") {
      employerPercent = 100.00;
      expectedFee =
          transactionFee! - ((employerPercent / 100) * transactionFee);
    } else if (paymentFee == "shared") {
      employerPercent = 50.00;
      expectedFee =
          transactionFee! - ((employerPercent / 100) * transactionFee);
    } else {
      employerPercent = 0.0;
      expectedFee =
          transactionFee! - ((employerPercent / 100) * transactionFee);
    }
    return expectedFee;
  }

  static String getInitials(String fullName) {
    List<String> names = fullName.split(" ");
    String initials = "";
    int numWords = 1;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }

  static String getBillName(String name) {
    List<String> names = name.split("_");
    String title = "";
    int numWords = 1;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      title += '${names[i].toUpperCase()} ';
    }
    return title;
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String getDayString(num? day) {
    String displayDay = "";
    if (day == null) {
      displayDay = "(0 Day)";
    } else if (day == 0) {
      displayDay = "(0 Day)";
    } else if (day == 1) {
      displayDay = "($day Days)";
    } else if (day > 1) {
      displayDay = "($day Days)";
    }
    return displayDay;
  }

  /// Get firebase push notification token from the device or [SessionManager] if its available
  /// Return generated [token];

  static double convertCurrencyStringToDouble(String amount) {
    String parsedAmount = (amount).replaceAll(RegExp(r'(,)'), '');
    return double.parse(parsedAmount);
  }

  static double convertToDouble(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      return Utility.convertCurrencyStringToDouble(value);
    }
  }

  static String currencyConverter(num amount) {
    // final currencyFormatter = NumberFormat.currency(symbol: EarnipayStrings.symbolNaira);
    final currencyFormatter = NumberFormat.currency(symbol: "₦");
    return currencyFormatter.format(amount);
  }

  static double convertToRealNumber(String value) {
    if (value.isEmpty) {
      value = "0";
    }
    // String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
    String onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
    double doubleValue = double.parse(onlyDigits);
    if (!value.contains(".")) {
      return doubleValue;
    }
    return doubleValue / 100;
  }

  static String dateConvertedNoDay(DateTime? date, {String format = ""}) {
    if (date == null) {
      return '';
    }
    if (format.isEmpty) return DateFormat('dd MMMM yyyy').format(date);
    return DateFormat(format).format(date.toLocal());
  }

  static String dateConvertedNoTime(DateTime? date, {String format = ""}) {
    if (date == null) {
      return '';
    }
    if (format.isEmpty) return DateFormat('EEEE, dd MMMM yyyy').format(date);
    return DateFormat(format).format(date.toLocal());
  }

  static String dateConverted(DateTime? date, {String format = ""}) {
    if (date == null) {
      return '';
    }
    if (format.isEmpty) {
      return DateFormat('EEEE, dd MMMM yyyy, hh:mm a').format(date);
    }
    return DateFormat(format).format(date.toLocal());
  }

  static DateTime? convertStringToDate(String? date) {
    if (date == null) {
      return null;
    }

    return DateTime.parse(date);
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static double roundDouble(double value, int places) {
    double mod = pow(10.0, places) as double;
    return ((value * mod).round().toDouble() / mod);
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static DateTime? getDataTimeFromString(String? formattedString) {
    if (formattedString == null) {
      return null;
    }
    if (formattedString.isEmpty) {
      return null;
    }
    return DateTime.parse(formattedString).toLocal();
  }

  static Duration getTimeFromNow(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    return difference;
  }

  static int getDayInt(String day) {
    switch (day.toLowerCase()) {
      case "monday":
        return DateTime.monday;
      case "tuesday":
        return DateTime.tuesday;
      case "wednesday":
        return DateTime.wednesday;
      case "thursday":
        return DateTime.thursday;
      case "friday":
        return DateTime.friday;
      case "saturday":
        return DateTime.saturday;
      case "sunday":
        return DateTime.sunday;

      default:
        return DateTime.monday;
    }
  }

  static Duration getTimeFromThisTime(DateTime time, DateTime date) {
    Duration difference = date.difference(time);
    return difference;
  }

  static String getPlatform() {
    return Platform.isAndroid ? "android" : "ios";
  }

  static String bufferString(String text, String character) {
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            '-'); // Replace this with anything you want to put after each 4 numbers
      }
    }

    return buffer.toString();
  }

  static String dateSuffix(String day) {
    switch (day.substring(day.length - 1)) {
      case "1":
        return 'st';
      case "2":
        return 'nd';
      case "3":
        return 'rd';
      default:
        return 'th';
    }
  }

  static int? calculateDaysLeft(
      {required DateTime? startDate,
      DateTime? endDate,
      required TextEditingController amount,
      required TextEditingController duration,
      TextEditingController? contribution,
      required int? noOfDays,
      fromEdit = false,
      String? savingFrequency,
      required String target}) {
    if (startDate != null && endDate != null) {
      noOfDays = endDate.difference(startDate).inDays + 1;
      if (amount.text.isNotEmpty) {
        num target = Utility.convertToRealNumber(amount.text.trim());
        if (target == 0) {
          duration.clear();
          return null;
        }

        int iterations = noOfDays;
        if (savingFrequency == "Weekly") {
          iterations = (noOfDays / 7).floor();
          duration.text = "$iterations week(s)";
        }
        if (savingFrequency == "Monthly") {
          iterations = (noOfDays / 30).floor();
          duration.text = "$iterations month(s)";
        }
        if (savingFrequency == "Daily") {
          duration.text = "$noOfDays day(s)";
        }
        double amountToSave = target / iterations;

        contribution?.text = Utility.currencyConverter(amountToSave);
        return noOfDays;
      }
    }
    return null;
  }

  static void calculateBreakFee(
      {required TextEditingController breaking,
      required TextEditingController amount,
      required num target}) {
    if (amount.text.isNotEmpty) {
      final num dailyContribution =
          Utility.convertToRealNumber(amount.text.trim());
      if (dailyContribution == 0) {
        breaking.clear();
        return;
      }

      breaking.text = Utility.currencyFormatter((1.5 / 100) * target);
    }
  }

  static int daysLeft(
      {required DateTime startDate,
      required num goalAmount,
      fromEdit = false,
      required num dailyContribution}) {
    if (goalAmount <= dailyContribution) {
      return 0;
    }

    final int numOfDays = (goalAmount / dailyContribution).ceil();
    return numOfDays;
  }

  /// Helper function to lauch any type of url.
  /// This can be used to launch a share intent, email or call intent etc.
}
