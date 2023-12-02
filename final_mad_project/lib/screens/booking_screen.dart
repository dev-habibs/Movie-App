import 'dart:ui';

import 'package:final_mad_project/constants/constant.dart';
import 'package:final_mad_project/models/movie_model.dart';
import 'package:final_mad_project/widget/build_chairs.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            // APP BARR
            CustomAppBar(context),
            // Date Selector
            DateSelector(context),
            // Time Selector
            TimeSelector(context),

            // Location
            LocationText(context),
            // Seat selections
            SeatSelector(context),
            // pay button and seat info
            PayButton(context),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}

Widget CustomAppBar(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Expanded(
      flex: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: appPadding / 2),
        child: Container(
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "TOGO",
                style: TextStyle(
                    color: white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Positioned(
                  left: 24,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: size.height * 0.075,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(color: white.withOpacity(0.35)),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: white,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ));
}

Widget DateSelector(BuildContext context) {
  int dateIndexSelected = 1;
  DateTime currentDate = DateTime.now();
  String _dayFormat(int dayWeek) {
    switch (dayWeek) {
      case 1:
        return "MO";
        break;
      case 2:
        return "TU";
        break;
      case 3:
        return "WE";
        break;
      case 4:
        return "TH";
        break;
      case 5:
        return "FR";
        break;
      case 6:
        return "SA";
        break;
      case 7:
        return "SU";
        break;
      default:
        return "MO";
    }
  }

  Size size = MediaQuery.of(context).size;
  return Expanded(
    flex: 15,
    child: Container(
      width: size.width,
      padding: EdgeInsets.only(left: appPadding * 1.5),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            decoration: BoxDecoration(
                color: white.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
          ),
          Container(
            width: size.width,
            child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var date = currentDate.add(Duration(days: index));
                  // throw '';
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        dateIndexSelected = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(appPadding / 5),
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.025,
                        horizontal: 12,
                      ),
                      width: 44,
                      decoration: BoxDecoration(
                        color: dateIndexSelected == index
                            ? primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                                color:
                                    index == dateIndexSelected ? black : white),
                          ),
                          Text(
                            _dayFormat(date.weekday),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: index == dateIndexSelected
                                  ? black
                                  : white.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}

Widget TimeSelector(BuildContext context) {
  int timeIntexSelected = 1;
  var time = [
    ["01:30", 5],
    ["06:30", 10],
    ["10;30", 15]
  ];

  Widget _timeItem(var time, var price, bool active) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: appPadding * 0.75),
      decoration: BoxDecoration(
        border: Border.all(
          color: active ? primary : white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: time,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: active ? primary : white,
                  ),
                  children: <TextSpan>[
                TextSpan(
                    text: 'PM',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: active ? primary : white,
                    ))
              ])),
          Text(
            'From ${price} ',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: grey,
            ),
          )
        ],
      ),
    );
  }

  Size size = MediaQuery.of(context).size;

  return Expanded(
    flex: 17,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.035),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: index == 0 ? 32 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  timeIntexSelected = index;
                });
              },
              child: _timeItem(time[index][0], time[index][1],
                  index == timeIntexSelected ? true : false),
            ),
          );
        },
      ),
    ),
  );
}

Widget LocationText(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: appPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          color: white,
          size: 30,
        ),
        SizedBox(
          width: 8.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cinepax Cinema',
              style: TextStyle(
                  color: white, fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Jinnah Park, Rawalpindi ',
              style: TextStyle(color: white.withOpacity(0.5), fontSize: 14.0),
            )
          ],
        )
      ],
    ),
  );
}

Widget SeatSelector(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  Widget _chairList() {
    //1 freee seats 2 selected 3 reserved
    var _chairStatus = [
      [3, 3, 3, 1, 3, 1, 1],
      [3, 1, 3, 1, 3, 1, 1],
      [3, 1, 3, 1, 3, 3, 3],
      [2, 2, 2, 1, 3, 3, 3],
      [1, 3, 3, 3, 3, 3, 3],
      [3, 3, 3, 3, 3, 3, 3],
    ];
    return Container(
      child: Column(
        children: [
          for (int i = 0; i < 6; i++)
            Container(
              margin: EdgeInsets.only(top: i == 3 ? size.height * 0.02 : 0),
              child: Row(
                children: [
                  for (int x = 0; x < 9; x++)
                    Expanded(
                      flex: x == 0 || x == 8 ? 2 : 1,
                      child: x == 0 ||
                              x == 8 ||
                              (i == 0 && x == 1) ||
                              (i == 0 && x == 7) ||
                              (x == 4)
                          ? Container()
                          : Container(
                              height: size.width / 11 - 18,
                              margin: EdgeInsets.all(5.0),
                              child: _chairStatus[i][x - 1] == 1
                                  ? BuildChairs.availableChairs()
                                  : _chairStatus[i][x - 1] == 2
                                      ? BuildChairs.selectedChairs()
                                      : BuildChairs.reservedChairs(),
                            ),
                    )
                ],
              ),
            )
        ],
      ),
    );
  }

  return Expanded(
    flex: 47,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
        ),

        //Cinema wali screen
        Positioned(
            top: 48,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.0),
                          topLeft: Radius.circular(50.0)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 114, 196),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 1],
                      )),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.55,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(40.0),
                      //     topLeft: Radius.circular(20.0)),
                      border: Border(
                          top: BorderSide(
                    width: 5.0,
                    color: Color.fromARGB(255, 248, 1, 145),
                  ))),
                ),
              ],
            )),

        // Cinema wali screen end

        // seats start

        Positioned(
          bottom: size.height * 0.02,
          child: Container(
            width: size.width,
            child: _chairList(),
          ),
        )
      ],
    ),
  );
}

Widget PayButton(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Expanded(
    flex: 13,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    height: 12.0,
                    width: 12.0,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: white),
                  ),
                  Text(
                    'Available',
                    style: TextStyle(
                        fontSize: 12,
                        color: white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 12.0,
                    width: 12.0,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromARGB(255, 177, 1, 59),
                    ),
                  ),
                  Text(
                    'Reserved',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 177, 1, 59),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 12.0,
                    width: 12.0,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 35, 252, 252)),
                  ),
                  Text(
                    'Selected',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 35, 252, 252),
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Container(
        //       height: size.height * 0.08,
        //       width: size.width * 0.45,
        //       child: Center(
        //         child: Text(
        //           '\$20.00',
        //           style: TextStyle(
        //             color: white,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //           ),
        //         ),
        //       ),
        //     ),
        //     FloatingActionButton(focusColor: secondary, onPressed: () {}
        //         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0))),
        //         ),
        //   ],
        // )
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookingScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                stops: const [0.2, 1.0],
                colors: [
                  Color.fromARGB(255, 243, 7, 86),
                  Color.fromARGB(255, 82, 9, 95),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            width: size.width * 0.55,
            height: size.height * 0.055,
            child: Center(
              child: Text(
                'PAY NOW',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void setState(Null Function() param0) {}
