import 'dart:math';

import 'package:brasil_fields/brasil_fields.dart';

bool containsString(String? needle, String? haystack) {
  return needle != null &&
      haystack != null &&
      haystack.toLowerCase().contains(needle.toLowerCase());
}

String limitString(String input, int maxLength, {bool addEllipsis = false}) {
  if (input.length <= maxLength) {
    return input;
  }

  if (addEllipsis && maxLength > 3) {
    return '${input.substring(0, maxLength - 3)}...';
  }

  return input.substring(0, maxLength);
}

bool isCpf(String value) {
  value = cleanSpecialCharacters(value);
  return value.length == 11;
}

bool isCnpj(String value) {
  value = cleanSpecialCharacters(value);
  return value.length == 14;
}

bool cpfIsValid(String cpf) {
  return UtilBrasilFields.isCPFValido(cleanSpecialCharacters(cpf));
}

bool cnpjIsValid(String cnpj) {
  return UtilBrasilFields.isCNPJValido(cleanSpecialCharacters(cnpj));
}

String cleanSpecialCharacters(String string) {
  return string.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
}

String removeSpaces(String input) {
  return input.replaceAll(RegExp(r'\s+'), '');
}

bool containsPlus(String input) {
  return input.contains('+');
}

String generateUniqueRandomString() {
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Random random = Random();
  int randomNumber = random.nextInt(10000);

  String uniqueString = '$timestamp$randomNumber';

  return uniqueString;
}

String camelToSnakeCase(String input) {
  final regex = RegExp(r'(?<=[a-z0-9])[A-Z]');
  return input
      .replaceAllMapped(regex, (match) => '_${match.group(0)}')
      .toLowerCase();
}
