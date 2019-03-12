import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState()=>_EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('未来事件'),
      ),
      body:Center(
       child: Text('未来安排',style: Theme.of(context).textTheme.display1,)
      )
    );
  }
  
}