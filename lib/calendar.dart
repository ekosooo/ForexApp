import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'model/calendarNews.dart';

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
                fontSize: 30.ssp,
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
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarNews calendarNews;
  List<CalendarNews> calendarFilter = [];

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2020, 07, 16): [
        Event(
          date: DateTime(2020, 07, 16),
          title: "Event 1",
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            color: Colors.white,
            height: 5.w,
            width: 5.w,
          ),
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  initState() {
    _markedDateMap.add(
      DateTime(2020, 7, 10),
      Event(
        date: DateTime(2020, 7, 10),
        title: "Event 2",
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          color: Colors.white,
          height: 5.w,
          width: 5.w,
        ),
      ),
    );

    calendarNews = CalendarNews();
    var now = DateTime.now();
    var timeNews = DateTime.parse("2020-07-19T09:26:00-0400");
    var timezoneOffset = now.timeZoneOffset;
    var testTime = timeNews.subtract(Duration(seconds: -7 * 3600));
    //var newTime = DateTime((now.year, now.month, now.day) + 7);
    var time = DateTime.parse("2020-07-19 10:15:00.000Z");
    time = time.toLocal();
    print("now $now");
    print("time $timezoneOffset");
    print("subtract $testTime");

    super.initState();
  }

  void refresh(DateTime date) {
    _currentDate = date;
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.white,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => refresh(date));
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: null,
      showOnlyCurrentMonthDate: false,
      weekdayTextStyle: TextStyle(
        color: Colors.white,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      showHeader: false,
      markedDatesMap: _markedDateMap,
      height: 600.w,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),
      todayButtonColor: Colors.white,
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 18.ssp,
        color: Color.fromRGBO(255, 255, 255, 0.5),
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 18.ssp,
        color: Color.fromRGBO(255, 255, 255, 0.5),
      ),
      daysTextStyle: TextStyle(color: Colors.white),
      weekendTextStyle: TextStyle(color: Colors.white),
      selectedDayButtonColor: Color.fromRGBO(8, 8, 8, 0.2),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    //------------------
    return Scaffold(
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       pinned: true,
      //       expandedHeight: 250.0,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text("Test"),
      //       ),
      //     ),
      //     SliverFixedExtentList(
      //       itemExtent: 50.0,
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           return Container(
      //             alignment: Alignment.center,
      //             color: Colors.lightBlue[100 * (index % 9)],
      //             child: Text('List Item $index'),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //---------------------header calendar
            Container(
              color: Color.fromRGBO(0, 147, 123, 1),
              padding: EdgeInsets.only(
                  top: 16.w, bottom: 10.w, left: 40.w, right: 16.w),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _currentMonth,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.ssp,
                          color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month - 1);
                        _currentMonth =
                            DateFormat.yMMMM().format(_targetDateTime);
                      });
                    },
                    child: Text(
                      "PREV",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth =
                            DateFormat.yMMMM().format(_targetDateTime);
                      });
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            //--------------------calendar
            Container(
              child: _calendarCarouselNoHeader,
              margin: EdgeInsets.only(bottom: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.w),
                  bottomRight: Radius.circular(40.w),
                ),
                color: Color.fromRGBO(0, 147, 123, 1),
              ),
            ),

            //-------------- list detail news
            Wrap(
              children: <Widget>[
                FutureBuilder(
                  future: calendarNews.getNews(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CalendarNews>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something wrong with message"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      List<CalendarNews> calendar = snapshot.data;
                      return _buildListViewCalendar(calendar);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildListViewCalendar(List<CalendarNews> calendar) {
  //filter data berdasrkan tanggal
  List<CalendarNews> filterList =
      calendar.where((data) => data.date.contains("2020-07-19")).toList();
  return ListView.separated(
    shrinkWrap: true,
    primary: false,
    separatorBuilder: (context, index) => Divider(
      color: Color.fromRGBO(242, 241, 242, 1),
      height: 20,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    ),
    //itemCount: calendar.length,
    itemCount: calendar.length,
    itemBuilder: (context, index) {
      //CalendarNews calendarNews = calendar[index];

      CalendarNews calendarNews = calendar[index];
      String dateTime = calendarNews.date;
      String time = dateTime.substring(11, 16);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: <Widget>[
            //------------ row title news
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  calendarNews.title,
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 28.ssp,
                  ),
                ),
                Text(
                  calendarNews.country,
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 28.ssp,
                  ),
                ),
              ],
            ),

            //--------------- row forecast impact actual time
            Padding(padding: EdgeInsets.only(top: 5.w)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //----------------- TIME AND IMPACT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      calendarNews.date,
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 22.ssp,
                      ),
                    ),
                    Container(
                      height: 45.w,
                      width: 93.w,
                      child: Center(
                        child: Text(
                          calendarNews.impact,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20.ssp,
                              color: Colors.white),
                        ),
                      ),
                      decoration: _boxDecorationImpact(calendarNews.impact),
                    ),
                  ],
                ),

                //--------------- ACTUAL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "-",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 22.ssp,
                      ),
                    ),
                    Text(
                      "Actual",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 22.ssp,
                      ),
                    ),
                  ],
                ),

                //--------------- Forecast
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _valueTextNews(calendarNews.forecast),
                    Text(
                      "Forecast",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 22.ssp,
                      ),
                    ),
                  ],
                ),

                //--------------- Previous
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _valueTextNews(calendarNews.previous),
                    Text(
                      "Previous",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 22.ssp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

//function jika nilai forecast atau previous "" maka akan di ganti menjadi -
Text _valueTextNews(String value) {
  if (value != "") {
    return Text(
      value,
      style: TextStyle(
        fontFamily: "PoppinsLight",
        fontSize: 22.ssp,
      ),
    );
  } else {
    return Text(
      "-",
      style: TextStyle(
        fontFamily: "PoppinsLight",
        fontSize: 22.ssp,
      ),
    );
  }
}

//function untuk mengganti warna box impact news
BoxDecoration _boxDecorationImpact(String impact) {
  if (impact == "High") {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5.w),
      color: Color.fromRGBO(192, 57, 43, 1),
    );
  } else if (impact == "Medium") {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5.w),
      color: Color.fromRGBO(230, 126, 34, 1),
    );
  } else {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5.w),
      color: Color.fromRGBO(50, 142, 78, 1),
    );
  }
}
