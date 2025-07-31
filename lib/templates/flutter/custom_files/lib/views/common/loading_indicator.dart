import 'package:flutter/material.dart';

Widget buildLoadingIndicator() {
  return const Center(
    child: SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}
