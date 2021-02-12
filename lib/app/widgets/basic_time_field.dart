import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicTimeField extends StatelessWidget {
  BasicTimeField({this.controller});
  final TextEditingController controller;

  final format = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      controller: controller,
      format: format,
      textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Uhrzeit',
          prefixIcon: Icon(Icons.access_time),
        ),
        onShowPicker: (context, value) async {
        final time = await showTimePicker(
          context: context,
            initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
        );
        return DateTimeField.convert(time);
      }
    );
  }
}
