import 'package:intl/intl.dart';

String formatToptBr(double value) {
  final NumberFormat format = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );

  return format.format(value);
}

String formatToMoney(double value) {
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  return currencyFormat.format(value);
}

double parsePtBrStringToDouble(String value) {
  try {
    String normalizedValue =
        value.trim().replaceAll('.', '').replaceAll(',', '.');
    return double.parse(normalizedValue);
  } catch (e) {
    return 0.0;
  }
}

int parsePtBrStringToInt(String value) {
  try {
    String normalizedValue =
        value.trim().replaceAll('.', '').replaceAll(',', '.');
    return int.parse(normalizedValue);
  } catch (e) {
    return 0;
  }
}

double roundToTwoDecimalPlaces(double value) {
  return (value * 100).round() / 100;
}

double toSum(double value, double element) {
  return value + element;
}

int toCents(double value) => (value * 100).round();

double getPercentualDiscount(double grossValue, double netValue) {
  return grossValue != 0 ? (1 - (netValue / grossValue)) * 100 : 0;
}

double parseDoubleOrZero(dynamic value) {
  if (value == null) return 0;
  return double.parse(value.toString());
}

double? parseDoubleOrNull(dynamic value) {
  if (value == null) return null;
  return double.parse(value.toString());
}
