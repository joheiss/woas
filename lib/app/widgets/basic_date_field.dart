import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicDateField extends StatelessWidget {
  BasicDateField({required this.controller});
  final TextEditingController controller;

  final format = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      controller: controller,
      format: format,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Datum',
        prefixIcon: Icon(Icons.date_range_rounded),
      ),
      onShowPicker: (context, value) {
        return showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 60)),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  bool isEmpty(dynamic value) {
    return value == null;
  }
}
