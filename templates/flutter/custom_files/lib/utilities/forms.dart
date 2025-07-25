import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'styles.dart';
import '../views/common/cursor_gesture_detector.dart';

Widget buildTextField({
  Key? key,
  TextEditingController? controller,
  String? label,
  String platform = 'mobile',
  String? hint,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  void Function(String?)? onChanged,
  List<TextInputFormatter>? formatters,
  int? maxLines = 1,
  bool enabled = true,
  bool readOnly = false,
}) {
  return TextFormField(
    key: key,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    inputFormatters: formatters,
    validator: validator,
    onChanged: onChanged,
    maxLines: maxLines,
    enabled: enabled,
    readOnly: readOnly,
    decoration: platform == 'mobile'
        ? buildMobileFormTextFieldDecoration(
            title: label,
            prefixButton: prefixIcon,
            suffixBtn: suffixIcon,
            hint: hint,
          )
        : buildWebFormTextFieldDecoration(
            title: label,
            prefixButton: prefixIcon,
            suffixBtn: suffixIcon,
            hint: hint,
          ),
  );
}

Widget buildDropdownFormField<T>({
  String? label,
  T? value,
  EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
  List<DropdownMenuItem<T>>? options,
  void Function(T?)? onChanged,
  double width = 250,
  String? Function(T?)? validator,
}) {
  return Padding(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ''),
        SizedBox(
          width: width,
          child: DropdownButtonFormField<T>(
            decoration: buildWebFormTextFieldDecoration(),
            value: value,
            items: options,
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    ),
  );
}

Widget buildDatePicker(BuildContext context, TextEditingController controller) {
  return CursorGestureDetector(
    onTap: () => handleDatePickerTap(context, controller),
    child: Icon(Icons.calendar_month),
  );
}

Future<void> handleDatePickerTap(
  BuildContext context,
  TextEditingController controller, {
  void Function()? callback,
}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    firstDate: DateTime(1900, 1, 1),
    lastDate: DateTime(2050, 12, 31),
  );

  if (selectedDate != null) {
    controller.text = DateFormat('dd/MM/yyyy').format(selectedDate);

    if (callback != null) {
      callback();
    }
  }
}
