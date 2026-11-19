import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class BasicTimeField extends StatelessWidget {
  BasicTimeField({required this.controller});
  final TextEditingController controller;

  final format = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Uhrzeit',
        prefixIcon: Icon(Icons.access_time),
      ),
      onTap: () async {
        DateTime initial;
        try {
          initial = format.parseStrict(controller.text);
        } catch (_) {
          initial = DateTime.now();
        }
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initial),
        );
        if (picked != null) {
          controller.text = format.format(DateTime(2000, 1, 1, picked.hour, picked.minute));
        }
      },
    );
  }
}
