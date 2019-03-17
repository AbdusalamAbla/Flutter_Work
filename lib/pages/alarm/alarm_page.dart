import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_work/model/scp_model.dart';
import 'dart:convert';
import 'package:flutter_work/service/db_service.dart';
import 'package:flutter_work/model/model.dart';

class AlarmPage extends StatefulWidget{
 final   CounterModel model;
 AlarmPage({@required this.model});
  _AlarmPageState createState()=>_AlarmPageState(model);

}
class _AlarmPageState extends State<AlarmPage>{
   final   CounterModel model;
   _AlarmPageState(this.model);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return   new Scaffold(
          appBar: AppBar(
        title: Text('测试页面'),
      ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return Text(
                  model.counter.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            RaisedButton(
        onPressed: _incrementCounter,
        child: Text('Increment Counter'),
        ),
              ],
              
            ),
          ), 
          floatingActionButton: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return FloatingActionButton(
            onPressed: model.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
        )
    )
      ;

  }

 _incrementCounter() async {    


  SQLServer sqlServer=new SQLServer();
    List<Map> results=await sqlServer.query();
    LocalMusic music;
  
    for (Map item in results) {
       music=LocalMusic.fromJson(item);
       print(music.title);
    }
    
    // print(music.title);
   

      
   

}
}

