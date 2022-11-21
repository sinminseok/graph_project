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



  @override
  Widget build(BuildContext context) {

    var dataMap = <String, double>{
      catigory_list[0]: 5,
      catigory_list[1]: 5,
      catigory_list[2]: 5,
      catigory_list[3]: 5,
    };

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
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
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 200),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    ringStrokeWidth: 32,
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
                              Icon(Icons.circle,color: Colors.grey,),
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
