import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotePageState createState()=>_NotePageState();
  
}

class _NotePageState extends State<NotesPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('记录页'),
      ),
      body: Center(
        child: new Text('记录',style: Theme.of(context).textTheme.display1,),
      ),
    );
  }

} 