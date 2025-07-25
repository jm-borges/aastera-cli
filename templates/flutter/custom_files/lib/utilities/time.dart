import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'global.dart';

DateTime getStartOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getEndOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
}

TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

String formatMinutesFromDoubleToHoursAndMinutes(int totalMinutes) {
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  if (minutes == 0) {
    return '${hours}h';
  } else {
    return '${hours}h ${minutes}m';
  }
}

TimeOfDay? getTimeOfDayFromTimeString(String? time) {
  if (time == null || time.isEmpty) {
    return null;
  }

  List<String> splittedTimeString = time.split(':');

  if (splittedTimeString.length < 2) {
    return null;
  }

  try {
    int hour = int.parse(splittedTimeString[0]);
    int minute = int.parse(splittedTimeString[1]);

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return null;
    }

    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    printOnDebug(e);
    return null;
  }
}

String getMonthNameByNumber(int selectedMonth) {
  switch (selectedMonth) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
    default:
      return 'Mês inválido';
  }
}

String formatTimestampForApi(DateTime? timestamp) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp ?? DateTime.now());
}

String formatBirthDateForApi(String input) {
  try {
    DateTime date = DateFormat('dd/MM/yyyy').parse(input);
    return DateFormat('yyyy-MM-dd').format(date);
  } catch (e) {
    return '';
  }
}

int calculateMinutesDifference(DateTime startTime, DateTime endTime) {
  return endTime.difference(startTime).inMinutes;
}

int getDifferenceInMinutes(
  TimeOfDay? first,
  TimeOfDay? second, {
  bool absolute = true,
}) {
  DateTime now = DateTime.now();

  DateTime firstDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    first?.hour ?? 0,
    first?.minute ?? 0,
  );
  DateTime secondDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    second?.hour ?? 0,
    second?.minute ?? 0,
  );

  Duration difference = secondDateTime.difference(firstDateTime);

  return absolute ? difference.inMinutes.abs() : difference.inMinutes;
}

DateTime? parsePtBrDateString(String dateString) {
  if (dateString.isEmpty) {
    return null;
  }

  final DateFormat fullYearFormat = DateFormat('dd/MM/yyyy');
  DateTime? date = fullYearFormat.tryParse(dateString);

  if (date == null) {
    final DateFormat shortYearFormat = DateFormat('dd/MM/yy');
    date = shortYearFormat.tryParse(dateString);
  }

  return date;
}

String? formatTimeOfDay(TimeOfDay? time, {bool includeSeconds = false}) {
  if (time == null) return null;

  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');

  return includeSeconds ? '$hour:$minute:00' : '$hour:$minute';
}
