import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static DateTime? _parse(String localDate) {
    try {
      return DateFormat('MM/dd/yyyy HH:mm').parse(localDate);
    } catch (e) {
      return null;
    }
  }

  static String formatTime(String localDate) {
    final d = _parse(localDate);
    return d != null ? DateFormat('HH:mm').format(d) : '';
  }

  static String formatDate(String localDate) {
    final d = _parse(localDate);
    return d != null ? DateFormat('MMM dd').format(d) : '';
  }

  static String formatTabDate(String dateKey) {
    try {
      final d = DateFormat('MM/dd/yyyy').parse(dateKey);
      return DateFormat('MMM d').format(d);
    } catch (e) {
      return dateKey;
    }
  }

  static String formatCapacity(int cap) {
    return cap.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}
