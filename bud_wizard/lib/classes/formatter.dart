import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatEnum(String enumStr) {
  return enumStr.toString().substring(enumStr.toString().indexOf('.') + 1);
}
