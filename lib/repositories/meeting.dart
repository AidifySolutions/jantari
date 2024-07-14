import 'dart:async';
import 'package:jantari/network_services/http_client.dart';
import 'package:intl/intl.dart';

// Models
import 'package:jantari/models/meeting.dart';

class MeetingRepository {
  final HttpClient? httpClient;
  final List roomEmails = [
    "meetingroomone@unikrew.com",
    "meetingroomtwo@unikrew.com"
  ];

  MeetingRepository({this.httpClient});

  Future getMeetings(int room) async {
    DateTime now = DateTime.now().toUtc();
    DateTime startOfDay = DateTime.utc(now.year, now.month, now.day);
    // DateTime endOfDay = startOfDay.add(const Duration(days: 1));
    DateFormat format = DateFormat('yyyy-MM-dd');
    String startOfDayString = '${format.format(startOfDay)}T00:00:00Z';
    String endOfDayString = '${format.format(startOfDay)}T23:59:59Z';

    // print('Start of day: $startOfDayString');
    // print('End of day: $endOfDayString');

    final response = await HttpClient.instance.fetchData(
        "/users/${roomEmails[room]}/calendar/calendarView?\$orderby=start/dateTime asc&startDateTime=$startOfDayString&endDateTime=$endOfDayString",
        null
    );

    List<Meeting> parsedResponse = response["value"].map<Meeting>((e) => Meeting
        .fromJson(e))
        .toList();

    return parsedResponse;
  }
}
