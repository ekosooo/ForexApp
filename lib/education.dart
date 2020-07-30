import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'customColor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationPage extends StatefulWidget {
  @override
  EducationPageState createState() => EducationPageState();
}

class EducationPageState extends State<EducationPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334);
    //Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: CustomColor.primary,
        ),
      ),
      home: Scaffold(
        backgroundColor: CustomColor.primary,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Education",
            style: TextStyle(
              fontFamily: "PoppinsMedium",
              fontSize: 32.ssp,
            ),
          ),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20.w,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 40.w, left: 25.w, right: 25.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    topRight: Radius.circular(50.w),
                  ),
                ),
                //color: Colors.white,
                // child: ListView(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   children: <Widget>[

                //   ],
                // ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildSpotlight(),
                        SizedBox(height: 25.w),
                        _buildTheory(),
                        SizedBox(height: 25.w),
                        _buildVideo(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //------------------ spotlight
  Widget _buildSpotlight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Spotlight",
          style: TextStyle(
            fontFamily: "PoppinsSemiBold",
            fontSize: 30.ssp,
          ),
        ),
        SizedBox(
          height: 15.w,
        ),
        Container(
          height: 302.w,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildContentSpotlight(),
              _buildContentSpotlight(),
              _buildContentSpotlight(),
            ],
          ),
        ),
      ],
    );
  }

  //content spotlight
  Widget _buildContentSpotlight() {
    return Container(
      margin: EdgeInsets.only(right: 25.w),
      width: 360.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),

      //--------- container item spotlight
      child: Column(
        children: <Widget>[
          //--------- container gambar atau vidio
          Container(
            height: 180.w,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(16.w)),
          ),

          //--------- container caoption
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 10.w,
              horizontal: 5.w,
            ),
            height: 120.w,
            child: Column(
              children: <Widget>[
                //-- caption
                Text(
                  'How to Identify Powerfull Support Resistence',
                  style: TextStyle(
                      fontFamily: "PoppinsMedium",
                      height: 2.w,
                      fontSize: 25.ssp),
                ),

                SizedBox(
                  height: 15.w,
                ),
                // like and see
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // ---------------- like
                      Container(
                        height: 20.w,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/icon/eye.png',
                              height: 15.w,
                              width: 23.w,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              '1200',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  height: 2.w,
                                  fontSize: 19.ssp,
                                  color: CustomColor.textSecondary),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 20.w,
                      ),

                      // ------------- see
                      Container(
                        height: 20.w,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/icon/like.png',
                                height: 18.w,
                                width: 23.w,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                '473',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    height: 2.w,
                                    fontSize: 19.ssp,
                                    color: CustomColor.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //---- build Theory
  Widget _buildTheory() {
    return Column(
      children: <Widget>[
        //--- row title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Theory",
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 30.ssp,
              ),
            ),
            Text(
              "See All",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.ssp,
              ),
            ),
          ],
        ),

        SizedBox(height: 10.w),
        //---- content
        _buildContentTheory(),
        _buildContentTheory(),
        _buildContentTheory(),
      ],
    );
  }

  //---- build Content Theory
  Widget _buildContentTheory() {
    return Container(
      margin: EdgeInsets.only(bottom: 25.w),
      height: 160.w,
      child: Row(
        children: <Widget>[
          Container(
            width: 160.w,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.w),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.w),
                    height: 110.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "How to Identitty Powerfull Support Resistence",
                          style: TextStyle(
                            fontFamily: "PoppinsMedium",
                            fontSize: 25.ssp,
                            height: 2.w,
                          ),
                        ),
                        SizedBox(
                          height: 2.w,
                        ),
                        Text(
                          "Lorem ipsum is simply dummy text of the printing is lorem ipsum of the printing is lorem ipsum..",
                          style: TextStyle(
                            fontFamily: "PoppinsMedium",
                            fontSize: 19.ssp,
                            height: 2.w,
                            color: CustomColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 30.w,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // ---------------- like
                            Container(
                              height: 20.w,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icon/eye.png',
                                    height: 15.w,
                                    width: 23.w,
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text(
                                    '1200',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        height: 2.w,
                                        fontSize: 19.ssp,
                                        color: CustomColor.textSecondary),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 20.w,
                            ),

                            // ------------- see
                            Container(
                              height: 20.w,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/icon/like.png',
                                      height: 18.w,
                                      width: 23.w,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      '473',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        height: 2.w,
                                        fontSize: 19.ssp,
                                        color: CustomColor.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //--------- build Video
  Widget _buildVideo() {
    //---- build Theory
    return Column(
      children: <Widget>[
        //--- row title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Video",
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 30.ssp,
              ),
            ),
            Text(
              "See All",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.ssp,
              ),
            ),
          ],
        ),

        SizedBox(height: 10.w),
        //---- content
        Container(
          height: 280.w,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildContentVideo(),
              _buildContentVideo(),
              _buildContentVideo(),
            ],
          ),
        ),
      ],
    );
  }

  //-- build content vidio
  Widget _buildContentVideo() {
    return Container(
      margin: EdgeInsets.only(right: 25.w),
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),

      //--------- container item spotlight
      child: Column(
        children: <Widget>[
          //--------- container gambar atau vidio
          Container(
            height: 150.w,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(16.w)),
          ),

          //--------- container caoption
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 10.w,
              horizontal: 5.w,
            ),
            height: 120.w,
            child: Column(
              children: <Widget>[
                //-- caption
                Text(
                  'How to Identify Powerfull Support Resistence',
                  style: TextStyle(
                      fontFamily: "PoppinsMedium",
                      height: 2.w,
                      fontSize: 20.ssp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
