import 'package:flutter/material.dart';

extension TimeOfDayFormatter on TimeOfDay {
  /// Formats the `TimeOfDay` instance to a string in the format `HH:mm:00`.
  ///
  /// Example output: `09:05:00` or `18:30:00`.
  String formatWithSeconds() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    return '$hours:$minutes:00';
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String format() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
  }
}