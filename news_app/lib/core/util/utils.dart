import 'package:intl/intl.dart';

String parseDate(String? date) {
  if (date == null) return 'Нет даты';
  final DateTime dateTime = DateTime.parse(date).toLocal();

  final String formatted = DateFormat('d MMMM HH:mm', 'ru').format(dateTime);
  return formatted;
}
