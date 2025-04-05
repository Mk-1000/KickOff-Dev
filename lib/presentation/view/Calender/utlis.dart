import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String stade;
  final String time;
  final String HomeImage;
  final String AwayImage;
  final String NameHome;
  final String NameAway;


  const Event(this.stade, this.time, this.HomeImage, this.AwayImage, this.NameHome, this.NameAway);

  @override
  String toString() => stade;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

// Predefined list of events for specific dates
final Map<DateTime, List<Event>> predefinedEvents = {
  DateTime(2024, 4, 10): [const Event('MAY Foot Land',"14/01/23 - 00:30 AM","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","WaBBro2","WaBBro2"),
  const Event('MAY Foot Land',"14/01/23 - 00:30 AM","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","WaBBro2","WaBBro2")
  ],
  DateTime(2023, 2, 20): [const Event('MAY Foot Land',"14/01/23 - 00:30 AM","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","WaBBro2","WaBBro2")],
  // Add more predefined events for specific dates as needed
  kToday: [const Event('MAY Foot Land',"14/01/23 - 00:30 AM","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","WaBBro2","WaBBro2"), const Event('MAY Foot Land',"14/01/23 - 00:30 AM","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png","WaBBro2","WaBBro2")], // Add today's events here if needed
};

final LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(predefinedEvents);

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
