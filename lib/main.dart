import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'model/calendarNews.dart';
import 'package:flutter/cupertino.dart';

import 'calendar.dart';
import 'education.dart';

EventList<Event> _markedDateMap = EventList<Event>();
List<String> arrImpact = ["Low", "Medium", "High"]; //impact news

void main() {
  //transparent status bar
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(EducationPage());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        //primarySwatch: Color.fromRGBO(0, 147, 123, 1),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(),
      home: BottomNavPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 160.w,
          padding: EdgeInsets.only(left: 25.w),
          margin: EdgeInsets.only(
            //left: 25.w,
            top: 30.w,
            bottom: 30.w,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildChildMenu(context, "calendar.png", "Calendar"),
              _buildChildMenu(context, "education.png", "Education"),
              _buildChildMenu(context, "robot.png", "EA Forex"),
              _buildChildMenu(context, "analysis.png", "Analysis"),
              _buildChildMenu(context, "indicator.png", "Indicator"),
              _buildChildMenu(context, "tools.png", "Tools"),
            ],
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override

  //menambahakan markcalendar untuk page calendar.dart. mengambil data terlebih dahulu dari api. kemudian data tersebut di panggil di calenda.dart
  void initState() {
    var arrFlag = List.generate(31, (index) => List(3), growable: false);
    for (int i = 0; i < 31; i++) {
      for (int j = 0; j < 3; j++) {
        arrFlag[i][j] = 0;
      }
    }

    CalendarNews calendarNews = CalendarNews();
    int tgl;
    int bln;
    int thn;

    List<int> listbln = [];

    _markedDateMap.clear();
    //List<String> dateNewsSplit;
    calendarNews.getNews().then((value) {
      for (var i = 0; i < value.length; i++) {
        // String dateNews = value[i].date.toString().substring(0, 10);
        // dateNewsSplit = dateNews.split("-");
        tgl = int.parse(value[i].date.toString().substring(8, 10));

        //thn = int.parse(value[i].date.toString().substring(0, 5));
        int impactVal = getImpactVal(value[i].impact);
        if (impactVal >= 0) {
          arrFlag[tgl - 1][impactVal] = 1;
          thn = int.parse(value[i].date.toString().substring(0, 4));
          bln = int.parse(value[i].date.toString().substring(5, 7));
          //listbln.add(bln);
        }
      }

      for (int i = 0; i < 31; i++) {
        int counter = 0;
        String strImpact = "";
        for (var j = 0; j < 3; j++) {
          if (arrFlag[i][j] == 1) {
            counter++;
            //strImpact += j.toString() + " ";
            int day = i + 1;
            //print("tgl $tgl");
            //print("tgl $i bln $bln thn $thn impact $j");
            addMarkCalendar(thn, bln, day, j);
          }
        }
        //counter akan memberikan informasi ada berapa jenis impact
      }
      //print(listbln.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(width: 720, height: 1280, allowFontScaling: false);
    ScreenUtil.init(width: 750, height: 1334);
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      //bottomNavigationBar: _buildBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSliderBuilder(),
            MenuPage(),
            _buildMarketHours(),
            _buildNews(),
            _buildContentNews(),
          ],
        ),
      ),
    );
  }
}

class CarouselSliderBuilder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildCarouselSlider();
  }
}

class _BuildCarouselSlider extends State<CarouselSliderBuilder> {
  static final List<String> imgSlider = [
    'promo.jpg',
    'promo1.jpg',
    'promo2.jpg'
  ];
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
              disableCenter: true,
              height: 450.w,
              autoPlay: true,
              aspectRatio: 2.0,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: imgSlider.map((fileImage) {
            return Container(
              child: Image.asset(
                'assets/images/slider/$fileImage',
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
        ),
        Container(
          margin: EdgeInsets.only(left: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: imgSlider.map((fileImage) {
              int index = imgSlider.indexOf(fileImage);
              return Container(
                width: 14.w,
                height: 14.w,
                margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 2.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 147, 123, 1)
                        : Color.fromRGBO(0, 0, 0, 0.1)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class BottomNavPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavPageState();
  }
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334);
    final _listPage = <Widget>[
      MyHomePage(),
      Text("2"),
      Text("3"),
      Text("4"),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/icon/home.png",
          width: 40.w,
          height: 40.w,
        ),
        title: Text(
          "Home",
          style: TextStyle(
            color: HexColor("#00937B"),
          ),
        ),
        activeIcon: Image.asset(
          "assets/images/icon/home.png",
          width: 40.w,
          height: 40.w,
          color: HexColor("#00937B"),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Signal"),
        activeIcon: Icon(
          Icons.home,
          color: HexColor("#EAEEF6"),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Notification"),
        activeIcon: Icon(
          Icons.home,
          color: HexColor("#EAEEF6"),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Profile"),
        activeIcon: Icon(
          Icons.home,
          color: HexColor("#EAEEF6"),
        ),
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      onTap: _onNavBarTapped,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blueAccent,
      type: BottomNavigationBarType.shifting,
      //fixedColor: Colors.amber,
    );

    return Scaffold(
      body: _listPage[_selectedTabIndex],
      bottomNavigationBar: _bottomNavBar,
    );
  }
}

@override
Widget _buildChildMenu(BuildContext context, String icon, String label) {
  return Container(
    margin: EdgeInsets.only(right: 35.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (label == "Calendar") {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => CalendarPage()));
            }
          },
          child: Container(
            width: 100.w,
            height: 100.w,
            padding: EdgeInsets.all(22.w),
            child: Image.asset(
              'assets/images/icon/$icon',
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.w),
              color: HexColor("#F7F7F7"),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.ssp,
            ),
          ),
        ),
      ],
    ),
  );
}

Container _buildContentMarketHours(String market, String open, String close) {
  return Container(
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(right: 16.w),
    width: 260.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.w),
      color: Color.fromRGBO(247, 247, 247, 1),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              'assets/images/icon/location.png',
              width: 20.w,
              height: 20.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, bottom: 10.w),
            ),
            Text(
              market,
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 25.ssp,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.w),
              child: Image.asset(
                'assets/images/icon/time.png',
                width: 18.w,
                height: 18.w,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Open",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.ssp,
                    ),
                  ),
                  Text(
                    open,
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold", fontSize: 20.ssp),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 12.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Close",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.ssp,
                    ),
                  ),
                  Text(
                    close,
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold", fontSize: 20.ssp),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Container _buildMarketHours() {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 25.w, bottom: 20.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Market Hours",
              style: TextStyle(fontFamily: "PoppinsBold", fontSize: 30.ssp),
            ),
          ],
        ),
        Container(
          height: 120.w,
          margin: EdgeInsets.only(top: 8.w),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildContentMarketHours("Sydney", "05.00 WIB", "14.00 WIB"),
              _buildContentMarketHours("Tokyo", "07.00 WIB", "16.00 WIB"),
              _buildContentMarketHours("London", "01.00 WIB", "10.00 WIB"),
              _buildContentMarketHours("New York", "20.00 WIB", "05.00 WIB"),
            ],
          ),
        ),
      ],
    ),
  );
}

Container _buildNews() {
  return Container(
    margin: EdgeInsets.only(top: 15.w, left: 25.w, right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "News",
          style: TextStyle(
            fontFamily: "PoppinsBold",
            fontSize: 30.ssp,
          ),
        ),
        Text(
          "See All",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 25.ssp,
          ),
        ),
      ],
    ),
  );
}

Container _buildContentNews() {
  return Container(
    height: 240.w,
    margin: EdgeInsets.only(left: 25.w, top: 8.w, bottom: 25.w),
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 320.w,
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: HexColor("#F7F7F7"),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w),
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/images/slider/news2.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 80.w,
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "China’s draconian security law for Hong Kong buries one country, two systems",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 18.ssp,
                    height: 2.w,
                  ),
                ),
              ),
            ],
          ),
        ),

        // -----------------------------------
        Container(
          width: 320.w,
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: HexColor("#F7F7F7"),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w),
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/images/slider/news1.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 80.w,
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "China’s draconian security law for Hong Kong buries one country, two systems",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 18.ssp,
                    height: 2.w,
                  ),
                ),
              ),
            ],
          ),
        ),
        //------------------------------------
        Container(
          width: 320.w,
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: HexColor("#F7F7F7"),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w),
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/images/slider/news2.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 80.w,
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "China’s draconian security law for Hong Kong buries one country, two systems",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 18.ssp,
                    height: 2.w,
                  ),
                ),
              ),
            ],
          ),
        ),
        //------------------------------------
      ],
    ),
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

getMarkCalendar() {
  return _markedDateMap;
}

addMarkCalendar(int thn, int bln, int tgl, var impact) {
  Color colorImpact;
  if (impact == 2) {
    //impact high
    //2 impact high
    colorImpact = Colors.red;
  } else if (impact == 1) {
    //impact medium
    //1 impact medium
    colorImpact = Colors.orange;
  } else if (impact == 0) {
    //impact low
    //0 impact low
    colorImpact = Colors.white;
  }
  _markedDateMap.add(
    DateTime(thn, bln, tgl),
    Event(
      date: DateTime(thn, bln, tgl),
      dot: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        color: colorImpact,
        height: 5.w,
        width: 5.w,
      ),
    ),
  );
}

int getImpactVal(String impact) {
  int val = -1;
  for (var i = 0; i < arrImpact.length; i++) {
    if (impact == arrImpact[i]) {
      val = i;
      break;
    }
  }
  return val;
}
