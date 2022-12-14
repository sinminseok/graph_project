import 'package:calendarproject/graph/controller/date_picker_controller.dart';
import 'package:calendarproject/graph/view/graphdetail_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Graph_View extends StatefulWidget {
  const Graph_View({Key? key}) : super(key: key);

  @override
  _Graph_ViewState createState() => _Graph_ViewState();
}

class _Graph_ViewState extends State<Graph_View> {
  final catigory_list = ["카테고리1","카테고리2","케테고리3","카테고리4"];
  DateTime date = DateTime.now();
  DateTime? picked_date;



  @override
  Widget build(BuildContext context) {

    var dataMap = <String, double>{
      catigory_list[0]: 5,
      catigory_list[1]: 5,
      catigory_list[2]: 5,
      catigory_list[3]: 5,
    };

    var color_list = [Colors.red,Colors.yellow,Colors.blue,Colors.white];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: InkWell(
            onTap: ()async{

            picked_date = await showDatePicker(context: context, initialDate:  date, firstDate: DateTime(2000), lastDate: DateTime(2200));
            setState(() {
              picked_date;
            });
            },
            child: picked_date != null? Text("${picked_date!.year} ${picked_date!.month} ${picked_date!.day}"):Text("${date.year} ${date.month} ${date.day}")),
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 60),
              child: Text(
                "총 지출 금액: ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                    //카테고리별 생상지정
                    colorList: [Colors.red,Colors.yellow,Colors.blue,Colors.white],
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 200),
                    chartLegendSpacing: 90,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    ringStrokeWidth: 10,
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      legendTextStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                ),
                //기존 차트에 딸려있는 목록을 지울수 없어 스택으로 감싸고 직접 카테고리 목록 구현
                Container(
                  margin: EdgeInsets.only(left: size.width*0.55,top: 7),
                  width: size.width*0.4,
                  height: size.height*0.2,
                  color: Colors.grey.shade200,
                  child: ListView.builder(

                    itemCount: catigory_list.length,
                    itemBuilder: (BuildContext context,int idx){
                      return   InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GraphDetail_View()),
                          );
                        },
                        child: Container(
                          width: size.width*0.35,
                          height: size.height*0.04,
                          child: Row(
                            children: [
                              Icon(Icons.circle,color: color_list[idx],),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text("${catigory_list[0]}"),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
