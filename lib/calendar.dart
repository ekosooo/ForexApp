import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class ScreenCalendar extends StatefulWidget {
  @override
  _ScreenCalendarState createState() => new _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334);
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color.fromRGBO(0, 147, 123, 1)),
      ),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "Calendar Economic",
              style: TextStyle(
                fontFamily: "PoppinsMedium",
                fontSize: 25.ssp,
              ),
            ),
            elevation: 0.0,
          ),
          body: CalendarPage()),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime(2020, 7, 18);
  DateTime _currentDate2 = DateTime(2020, 7, 18);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 7, 18));
  DateTime _targetDateTime = DateTime(2020, 7, 18);

  static Widget _eventIcon = new Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.blue, width: 2.0),
    ),
    child: Icon(Icons.person, color: Colors.amber),
  );

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2020, 07, 16): [
        Event(
          date: DateTime(2020, 07, 16),
          title: "Event 1",
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            color: Colors.red,
            height: 5.w,
            width: 5.w,
          ),
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    _markedDateMap.add(
      DateTime(2020, 7, 10),
      Event(
        date: DateTime(2020, 7, 10),
        title: "Event 2",
        icon: _eventIcon,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      prevMonthDayBorderColor: Colors.white,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 600.w,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: true,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.black,
      markedDateMoreShowTotal: true,
      prevDaysTextStyle: TextStyle(
        fontSize: 20.ssp,
        color: Colors.white,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      selectedDayTextStyle: TextStyle(
        color: Colors.black,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      daysTextStyle: TextStyle(color: Colors.black),
      weekendTextStyle: TextStyle(color: Colors.white),
      //headerText: "Custom Header",
      headerTextStyle: TextStyle(
          color: Colors.white, fontFamily: "PoppinsSemi", fontSize: 40.ssp),
    );

    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.white,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      //daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekdayTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 700.w,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: CircleBorder(
        side: BorderSide(color: Colors.yellow),
      ),
      markedDateCustomTextStyle:
          TextStyle(fontSize: 18.ssp, color: Colors.blue),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.black,
      selectedDayTextStyle: TextStyle(color: Colors.yellow),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16.ssp,
        color: Colors.pinkAccent,
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 16.ssp,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16.ssp,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    //------------------
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              //margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: _calendarCarousel,
            ),
            //custom icon whitout header
            Container(
              margin: EdgeInsets.only(
                  top: 30.w, bottom: 16.w, left: 40.w, right: 16.w),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _currentMonth,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.ssp),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month - 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                    child: Text("PREV"),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                    child: Text("NEXT"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarouselNoHeader,
            ),
          ],
        ),
      ),
    );
  }
}
