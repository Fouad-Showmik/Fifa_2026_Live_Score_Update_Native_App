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
  
  
  static List<String> parseScorers(String? raw) {
    if (raw == null || raw.isEmpty || raw == 'null') return [];

    final trimmed = raw.trim();
    if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return [];

    final inner = trimmed.substring(1, trimmed.length - 1);
    if (inner.isEmpty) return [];

    final results = <String>[];
    final buffer = StringBuffer();
    bool inQuotes = false;

    for (int i = 0; i < inner.length; i++) {
      final ch = inner[i];
      if (ch == '"') {
        inQuotes = !inQuotes;
      } else if (ch == ',' && !inQuotes) {
        final s = buffer.toString().trim();
        if (s.isNotEmpty) results.add(s);
        buffer.clear();
      } else {
        buffer.write(ch);
      }
    }

    final last = buffer.toString().trim();
    if (last.isNotEmpty) results.add(last);

    return results;
  }
}
