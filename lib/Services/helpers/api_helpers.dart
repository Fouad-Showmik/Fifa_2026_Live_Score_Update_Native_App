class ApiHelper {
  static List<Map<String, dynamic>> parseList(dynamic data, String key) {
    if (data is Map<String, dynamic>) {
      return ((data[key] as List?) ?? []).cast<Map<String, dynamic>>();
    }
    if (data is List) return data.cast<Map<String, dynamic>>();
    return [];
  }
}