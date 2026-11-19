import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class BasicDateField extends StatelessWidget {
  BasicDateField({required this.controller});
  final TextEditingController controller;

  final format = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Datum',
        prefixIcon: Icon(Icons.date_range_rounded),
      ),
      onTap: () async {
        final now = DateTime.now();
        DateTime initial;
        try {
          initial = format.parseStrict(controller.text);
        } catch (_) {
          initial = now;
        }
        final first = now.subtract(Duration(days: 60));
        final picked = await showDatePicker(
          context: context,
          initialDate: initial.isBefore(first) || initial.isAfter(now) ? now : initial,
          firstDate: first,
          lastDate: now,
        );
        if (picked != null) controller.text = format.format(picked);
      },
    );
  }
}
