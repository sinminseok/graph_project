
import 'package:flutter/cupertino.dart';

//data는 수입,지출,총합 내용을 포함한 객체로 넘겨준뒤 해당 객체에 접근해 얻도록 구현하시면 됩니다
Widget Day_Widget(Size size, day,data){
  return Container(
      width: size.width * 0.1,
      height: size.height * 0.1,
      child: Column(children: [
        Text("${day}"),
        data==null?Container():
            Column(
              children: [
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
              ],
            )

      ]));
}