import 'package:flutter/material.dart';

Widget buildBackButtonRow(BuildContext context) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
