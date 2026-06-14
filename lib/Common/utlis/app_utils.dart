import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static final _fmt = DateFormat('MM/dd/yyyy HH:mm');

  // Parses raw API date string into DateTime
  static DateTime? parseLocalDate(String raw) {
    if (raw.isEmpty) return null;
    try {
      return _fmt.parse(raw);
    } catch (e) {
      return null;
    }
  }

  // "HH:mm" — used on match cards for upcoming matches
  static String formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  // "MMM d" — used for fixture date pills 
  static String formatTabDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM d').format(date);
  }

  // used for grouping matches by date
  static String dateKey(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MM/dd/yyyy').format(date);
  }

  // Formats capacity with commas e.g. 94000 → "94,000"
  static String formatCapacity(int cap) {
    return cap.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}
