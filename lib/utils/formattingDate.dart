import 'package:intl/intl.dart';

String formattingDate({
  String format = 'EEEE, d MMMM y',
  DateTime? date,
}) {
  if (date != null) {
    String formattedDate = DateFormat(format).format(date);

    return formattedDate;
  }

  return '';
}
