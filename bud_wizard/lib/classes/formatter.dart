import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatDateDisplay(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}

String formatDateDisplayDetailed(DateTime date) {
  return DateFormat('MMM d, yyyy hh:mm aaa').format(date);
}

String formatEnum(String enumStr) {
  return enumStr.toString().substring(enumStr.toString().indexOf('.') + 1);
}
