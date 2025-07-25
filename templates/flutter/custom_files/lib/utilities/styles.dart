import 'package:flutter/material.dart';

InputDecoration buildMobileFormTextFieldDecoration({
  String? title,
  String? hint,
  Widget? prefixButton,
  Widget? suffixBtn,
}) {
  return InputDecoration(
    labelText: title,
    labelStyle: const TextStyle(fontSize: 14),
    hintText: hint,
    prefixIcon: prefixButton,
    suffixIcon: suffixBtn,
    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
    enabledBorder: buildDecorationBorder(),
    border: buildDecorationBorder(),
  );
}

InputDecoration buildWebFormTextFieldDecoration({
  String? title,
  String? hint,
  Widget? prefixButton,
  Widget? suffixBtn,
}) {
  return InputDecoration(
    labelText: title,
    labelStyle: const TextStyle(fontSize: 14),
    hintText: hint,
    prefixIcon: prefixButton,
    suffixIcon: suffixBtn,
    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
    enabledBorder: buildDecorationBorder(),
    border: buildDecorationBorder(),
  );
}

InputDecoration buildDropdownDecoration({String? label, String? hint}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(fontSize: 14),
    hintText: hint,
    contentPadding: buildDropdownPadding(),
    enabledBorder: buildDecorationBorder(),
    border: buildDecorationBorder(),
  );
}

EdgeInsets buildDropdownPadding() {
  return const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15);
}

OutlineInputBorder buildDecorationBorder() {
  return const OutlineInputBorder(borderSide: BorderSide());
}

ButtonStyle buildStdButtonStyle() {
  return ElevatedButton.styleFrom();
}

BoxDecoration buildContainerDecoration() {
  return BoxDecoration(
    border: Border.all(width: 1, color: Colors.grey[400]!),
    borderRadius: BorderRadius.circular(4),
    color: const Color.fromRGBO(248, 250, 252, 1.0),
  );
}

BoxDecoration buildFieldDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    border: Border.all(width: 1, color: Colors.grey[400]!),
    color: Colors.white,
  );
}
