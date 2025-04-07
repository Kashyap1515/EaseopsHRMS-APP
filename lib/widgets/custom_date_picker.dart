import 'package:easeops_hrms/app_export.dart';

Future<DateTime?> customSelectDate({
  required DateTime selectedDate,
}) async {
  final picked = await showDatePicker(
    builder: (context, child) => Theme(
      data: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      child: child!,
    ),
    context: Get.context!,
    initialDate: selectedDate,
    firstDate: DateTime(2022),
    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
  );
  if (picked != null) {
    // selectedDate = picked;
    // final date = DateFormat('dd/MM/yyyy').format(selectedDate);
    return picked;
  } else {
    return null;
  }
}
