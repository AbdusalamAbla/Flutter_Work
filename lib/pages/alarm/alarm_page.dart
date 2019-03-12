import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
class AlarmPage extends StatefulWidget{
  @override
  _AlarmPageState createState()=>_AlarmPageState();

}
class _AlarmPageState extends State<AlarmPage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onPressed();
  }

  //  initFood() async{
  //   int result = await compute(_calculate, 5);
  //   print(result);
  // }
  int _counter;

 static  int loop(int val) {
    int count = 0;
    for (int i = 1; i <= val; i++) {
      count += i;
    }
    return count;
  }

  Future<void> _onPressed() async {
    int result = await compute(loop, 100);
    setState(() {
      _counter = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    // initFood();
     DateTime now=new DateTime.now();
      String date=now.month.toString()+"月"+now.day.toString()+"日 周"+ChargeWeek().get(now.weekday.toInt())+"  ";
    return Scaffold(
    appBar: AppBar(
      title: Text('通知闹钟'),
    ),
    body:Row(
      children: <Widget>[
        Text(
             date,
             style:Theme.of(context).textTheme.display1
             ),
       Text(
         '$_counter',style:Theme.of(context).textTheme.display1
       )
      ],
    ) 
    )
    ;
  }






}

class ChargeWeek {
  String get(int num){
    switch (num) {
      case 1:return "一";break;
      case 2:return "二";break; 
      case 3:return "三";break;
      case 4:return "四";break;
      case 5:return "五";break;
      case 6:return "六";break;
      case 7:return "日";break;
      default: return ''; break;
    }
  }
}