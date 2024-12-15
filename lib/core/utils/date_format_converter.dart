import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatConverter {
  static DateFormat dayMonthYear = DateFormat("d MMM yyyy");

  static String formatDateToDayMonthYear(String? date) {
    return formatDateWithPattern(date, dayMonthYear);
  }

  static String formatDateWithPattern(String? date, DateFormat dateFormat) {
    if (date == null || date.isEmpty) return "";
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return dateFormat.format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}