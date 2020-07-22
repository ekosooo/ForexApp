import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CalendarNews {
  String title;
  String country;
  String date;
  String impact;
  String forecast;
  String previous;

  CalendarNews({
    this.title,
    this.country,
    this.date,
    this.impact,
    this.forecast,
    this.previous,
  });

  factory CalendarNews.fromJson(Map<String, dynamic> json) => CalendarNews(
        title: json["title"],
        country: json["country"],
        date: json["date"],
        impact: json["impact"],
        forecast: json["forecast"],
        previous: json["previous"],
      );

  List<CalendarNews> calendarFromJson(String jsonData) {
    List data = json.decode(jsonData);
    return List<CalendarNews>.from(
        data.map((item) => CalendarNews.fromJson(item)));
  }

  Future<List<CalendarNews>> getNews() async {
    final String baseUrl =
        "https://cdn-nfs.faireconomy.media/ff_calendar_thisweek.json";
    final response = await http.get("$baseUrl");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return calendarFromJson(response.body);
    } else {
      return null;
    }
  }
}
