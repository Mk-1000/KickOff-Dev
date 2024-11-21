import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DateTimeUtils {
  static const _currentTimeApiUrl = 'https://api.currenttime.co/v1/timestamp';

  static DateTime getCurrentDateTime() => DateTime.now();

  // Fetches the current date and time from the API if available,
  // otherwise falls back to local time
  Future<DateTime> getCurrentDateTimeOrFallback() async {
    try {
      final response = await http.get(Uri.parse(_currentTimeApiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final timestamp = data['timestamp'];
        if (timestamp != null) {
          return DateTime.parse(timestamp);
        }
      }
    } catch (e) {
      print('Error fetching timestamp from API: $e');
    }
    // Fallback to local time if API request fails or timestamp is not available
    return DateTime.now();
  }

  // Example of determining the UTC offset for a given time zone
  static int timeZoneOffset(String timeZone) {
    switch (timeZone) {
      case 'UTC':
        return 0;
      case 'EST':
        return -5;
      // Add more cases for other time zones
      default:
        return 0;
    }
  }

  // Converts DateTime to a timestamp in milliseconds
  static int toTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  // Convertit un timestamp en DateTime
  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // Formate un timestamp en chaîne de date
  static String formatTimestamp(int timestamp,
      {String format = 'dd/MM/yyyy HH:mm'}) {
    final dateTime = fromTimestamp(timestamp);
    final formatter = DateFormat(format);
    return formatter.format(dateTime);
  }
}
