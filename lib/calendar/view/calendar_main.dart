import 'package:calendarproject/graph/view/graph_view.dart';
import 'package:date_utils/date_utils.dart' as dt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_model.dart';

class Calendar_Main extends StatefulWidget {
  const Calendar_Main({Key? key}) : super(key: key);

  @override
  _Calendar_MainState createState() => _Calendar_MainState();
}

class _Calendar_MainState extends State<Calendar_Main> {
  //해당 달에 포함되는 일 List
  List<String?> date_list = [];
  Future? myfuture;
  DateTime? now;
  var daysinmonth;

  //삽입 데이터 list
  List<Data?> data_list = [];

  void test() {
    for (var i = 0; i < 10; i++) {
      Data data = Data();
      data.id = i;
      data.input = 500;
      data.output = 500;
      data.total = 1000;
      data.datetime = "2022";
    }
  }

  //현재 화면 달,년도
  var this_month;
  var this_year;

  @override
  void initState() {
    date_list = [];
    data_list = [];
    get_datetime();
    get_date_list();
    super.initState();
  }

  get_datetime() {
    now = DateTime.now();
    daysinmonth = dt.DateUtils.daysInMonth(now!);
    this_month = now!.month;
    this_year = now!.year;
  }

  filter_string_date(String date) {
    if (date.substring(0, 1) == "0") {
      return date.substring(1, 2);
    } else {
      return date;
    }
  }

  get_date_list() {
    for (var i = 0; i < daysinmonth.length; i++) {
      var this_date;
      this_date =
          filter_string_date(daysinmonth[i].toString().substring(8, 10));
      date_list.add(this_date);
    }
  }

  //저번달로 넘기는 함수
  set_datesub_list() {
    date_list = [];

    setState(() {
      if (this_month - 1 == 0) {
        this_year = this_year - 1;
        this_month = 12;
      } else {
        this_month -= 1;
      }
      DateTime date_time = DateTime(this_year, this_month);
      daysinmonth = dt.DateUtils.daysInMonth(date_time);
      date_list = [];
      for (var i = 0; i < daysinmonth.length; i++) {
        var this_date;
        this_date =
            filter_string_date(daysinmonth[i].toString().substring(8, 10));
        date_list.add(this_date);
      }
    });
    // local_data_filter_year();
  }

  //다음달로 넘기는 함수
  set_dateplus_list() {
    date_list = [];

    setState(() {
      if (this_month + 1 == 13) {
        this_year = this_year + 1;
        this_month = 1;
      } else {
        this_month += 1;
      }

      DateTime date_time = DateTime(this_year, this_month);
      daysinmonth = dt.DateUtils.daysInMonth(date_time);
      date_list = [];
      for (var i = 0; i < daysinmonth.length; i++) {
        var this_date;
        this_date =
            filter_string_date(daysinmonth[i].toString().substring(8, 10));
        date_list.add(this_date);
      }
      print(date_list);
    });

    // local_data_filter_year();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graph_View()),
              );
            },
            child: Text("그래프 화면전환 ")),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  set_datesub_list();
                },
                child: Icon(
                  Icons.arrow_left,
                  size: 50,
                )),
            InkWell(
              onTap: () {
                test();
              },
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$this_year 년 $this_month 월",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )
                ],
              )),
            ),
            InkWell(
                onTap: () {
                  set_dateplus_list();
                },
                child: Icon(
                  Icons.arrow_right,
                  size: 50,
                )),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Container(
          width: size.width * 1,
          height: size.height * 0.7,
          child: Column(
            children: [
              //요일 ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "일",
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: "gilogfont",
                        fontSize: 20),
                  ),
                  Text(
                    "월",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                  ),
                  Text(
                    "화",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                  ),
                  Text(
                    "수",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                  ),
                  Text(
                    "목",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                  ),
                  Text(
                    "금",
                    style: TextStyle(fontFamily: "gilogfont", fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      print(date_list[6]);
                    },
                    child: Text(
                      "토",
                      style: TextStyle(
                          fontFamily: "gilogfont",
                          fontSize: 20,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Column(
                children: [
                  date_list.length == 42
                      ? date_list[6] == "31"
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[0]}"),
                                    ])),
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[1]}"),
                                    ])),
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[2]}"),
                                    ])),
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[3]}"),
                                    ])),
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[4]}"),
                                    ])),
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[5]}"),
                                    ])),
                                Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.1,
                                    child: Column(children: [
                                      Text("${date_list[6]}"),
                                    ])),
                              ],
                            )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[0]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[1]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[2]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[3]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[4]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[5]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[6]}"),
                                ])),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[7]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[8]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[9]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[10]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[11]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[12]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[13]}"),
                          ])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[14]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[15]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[16]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[17]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[18]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[19]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[20]}"),
                          ])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[21]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[22]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[23]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[24]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[25]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[26]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[27]}"),
                          ])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[28]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[29]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[30]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[31]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[32]}"),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "수입 : 1000",
                                style: TextStyle(fontSize: 7),
                              ),
                            ),
                            Text(
                              "수입 : 1000",
                              style: TextStyle(fontSize: 7),
                            ),
                            Text(
                              "수입 : 1000",
                              style: TextStyle(fontSize: 7),
                            ),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[33]}"),
                          ])),
                      Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          child: Column(children: [
                            Text("${date_list[34]}"),
                          ])),
                    ],
                  ),
                  date_list.length == 42
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[35]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[36]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[37]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[38]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[39]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[40]}"),
                                ])),
                            Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                child: Column(children: [
                                  Text("${date_list[41]}"),
                                ])),
                          ],
                        )
                      : Container(),
                  
                  Text("수입: 지출: 총합:",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),)
                ],
              )
            ],
          ),
        ),
      ],
    )));
  }
}
