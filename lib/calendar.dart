import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'model/calendarNews.dart';
import 'main.dart' as main;
import 'colorCustom.dart';

//EventList<Event> _markedDateMap = EventList<Event>();
//CalendarCarousel _calendarCarouselNoHeader;
CalendarCarousel<Event> _calendarCarouselNoHeader = CalendarCarousel<Event>();
bool _checkHigh = false;
bool _checkMedium = false;
bool _checkLow = false;

class ScreenCalendar extends StatefulWidget {
  @override
  _ScreenCalendarState createState() => new _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Filter News"),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //----------- high
                        Checkbox(
                          activeColor: ColorCustom.primary,
                          value: _checkHigh,
                          onChanged: (bool response) {
                            setState(() {
                              _checkHigh = response;
                              print("High $_checkHigh");
                            });
                          },
                        ),
                        Text(
                          "High",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25.ssp,
                          ),
                        ),

                        //--------- medium
                        Checkbox(
                          activeColor: ColorCustom.primary,
                          value: _checkMedium,
                          onChanged: (bool response) {
                            setState(() {
                              _checkMedium = response;
                              print("Medium $_checkMedium");
                            });
                          },
                        ),
                        Text(
                          "Medium",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25.ssp,
                          ),
                        ),

                        //--------- low
                        Checkbox(
                          activeColor: ColorCustom.primary,
                          value: _checkLow,
                          onChanged: (bool response) {
                            setState(() {
                              _checkLow = response;
                              print("Low $_checkLow");
                            });
                          },
                        ),
                        Text(
                          "Low",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25.ssp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 20.ssp,
                      color: ColorCustom.primary,
                    ),
                  ),
                  onPressed: () {
                    print("High $_checkHigh");
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        });
  }

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
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 25.w),
                child: GestureDetector(
                  onTap: () {
                    _showDialog();
                  },
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
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

  CalendarNews calendarNews = CalendarNews();
  List<CalendarNews> calendarFilter = [];
  bool flagEventToday = true;
  DateTime dateSelectedEvent;

  @override
  initState() {
    // calendarNews = CalendarNews();

    // calendarNews.getNews().then((value) {
    //   for (var i = 0; i < value.length; i++) {
    //     String dateNews = value[i].date.toString().substring(0, 10);
    //     print(dateNews);
    //     List<String> dateNewsSplit = dateNews.split("-");
    //     //print(dateNewsSplit[0]);

    //     _markedDateMap.add(
    //       DateTime(int.parse(dateNewsSplit[0]), int.parse(dateNewsSplit[1]),
    //           int.parse(dateNewsSplit[2])),
    //       Event(
    //         date: DateTime(int.parse(dateNewsSplit[0]),
    //             int.parse(dateNewsSplit[1]), int.parse(dateNewsSplit[2])),
    //         title: calendarNews.title,
    //         dot: Container(
    //           margin: EdgeInsets.symmetric(horizontal: 1.w),
    //           color: Colors.white,
    //           height: 5.w,
    //           width: 5.w,
    //         ),
    //       ),
    //     );
    //   }
    // });

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
        flagEventToday = false;
        dateSelectedEvent = date;
        print(date);
      },
      daysHaveCircularBorder: null,
      showOnlyCurrentMonthDate: false,
      weekdayTextStyle: TextStyle(
        color: Colors.white,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      showHeader: true,
      iconColor: Colors.white,
      headerTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "PoppinsMedium",
        fontSize: 30.ssp,
      ),
      markedDatesMap: main.getMarkCalendar(),
      height: 700.w,
      headerMargin: EdgeInsets.symmetric(vertical: 2.0),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //---------------------header calendar
            // Container(
            //   color: Color.fromRGBO(0, 147, 123, 1),
            //   padding: EdgeInsets.only(
            //       top: 16.w, bottom: 10.w, left: 40.w, right: 16.w),
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: Text(
            //           _currentMonth,
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 40.ssp,
            //               color: Colors.white),
            //         ),
            //       ),
            //       FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _targetDateTime = DateTime(
            //                 _targetDateTime.year, _targetDateTime.month - 1);
            //             _currentMonth =
            //                 DateFormat.yMMMM().format(_targetDateTime);
            //             print("PREV " + _currentMonth);
            //           });
            //         },
            //         child: Text(
            //           "PREV",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //       FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _targetDateTime = DateTime(
            //                 _targetDateTime.year, _targetDateTime.month + 1);
            //             _currentMonth =
            //                 DateFormat.yMMMM().format(_targetDateTime);
            //           });
            //           print("NEXT " + _currentMonth);
            //         },
            //         child: Text(
            //           "NEXT",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

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
                //color: Colors.black,
              ),
            ),

            //-------------- list detail news
            Padding(padding: EdgeInsets.only(top: 20.w)),
            Wrap(
              children: <Widget>[
                //_featureBuild(),
                FutureBuilder(
                  future: calendarNews.getNews(),
                  builder: (BuildContext mcontext,
                      AsyncSnapshot<List<CalendarNews>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something wrong with message"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      List<CalendarNews> calendarData = snapshot.data;
                      if (flagEventToday) {
                        return _buildListViewCalendar(
                            calendarData, DateTime.now());
                      } else {
                        return _buildListViewCalendar(
                            calendarData, dateSelectedEvent);
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(bottom: 30.w)),
          ],
        ),
      ),
    );
  }
}

Widget _buildListViewCalendar(
    List<CalendarNews> calendar, DateTime dateSelected) {
  //filter data berdasrkan tanggal
  String dateSelectedStr = dateSelected.toString().substring(0, 10);

  List<CalendarNews> filterList = calendar
      .where((data) => data.date.toString().contains(dateSelectedStr))
      .toList();

  //_markedDateMap.clear();
  if (filterList.length == 0) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/nodata.png',
            height: 300.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.w),
          ),
          Text(
            "No News Today",
            style: TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontSize: 30.ssp,
              color: Color.fromRGBO(19, 19, 19, 1),
            ),
          )
        ],
      ),
    );
  } else {
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
      itemCount: filterList.length,
      itemBuilder: (context, index) {
        CalendarNews calendarNews = filterList[index];

        String dateNews = calendarNews.date.toString().substring(0, 10);
        String timeNews = calendarNews.date.toString().substring(11, 16);

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
                        dateNews + " " + timeNews,
                        //dateNews + " " + timeNews,
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
