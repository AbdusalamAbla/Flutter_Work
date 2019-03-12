import 'package:flutter/material.dart';
import 'bloc.dart';
import 'dart:async';
import './pages/music/music_page_search.dart';
int i = 0;

class AVBlocData implements BlocBase {
  int _count;

  StreamController<int> _countController = new StreamController();
  StreamSink<int> get _inadd => _countController.sink;
  Stream<int> get outCount => _countController.stream;

  StreamController _actionController = new StreamController();
  StreamSink get updateCount => _actionController.sink;
  
  AVBlocData(){
    _count = 1;
    // Future.delayed(const Duration(seconds:5), () => print('after 5 s'));
    _actionController.stream.listen(_handleLogic);
  }

  void _handleLogic(data){
    _count = data + 1;
    _inadd.add(_count);
  }

  void dispose(){ 
    _countController.close();
    _actionController.close();
  }
}
class AVBlocPage extends StatefulWidget{
  @override 
_AVBlocPageState createState()=>_AVBlocPageState();
}
class _AVBlocPageState extends State<AVBlocPage> {
  int _lastIntegerSelected=0;
  final List<int> building=[];

  @override
  Widget build(BuildContext context) {
    
    final AVBlocData bloc =  BlocProvider.of<AVBlocData>(context);
    return new Scaffold(
      appBar: AppBar(
        title: Text('音乐界面'),
        actions: <Widget>[
        IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                delegate: searchDelegate,
              );
              if (selected != null && selected != _lastIntegerSelected) {
                setState(() {
                  _lastIntegerSelected = selected;
                });
              }
            },
          ),
      ],),
      body: new Center(
        child: StreamBuilder<int>(
          stream: bloc.outCount,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            return Text('now it is ${snapshot.data}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: (){
          bloc.updateCount.add(i++);
        },
      ),
    );
  }
}
class AVBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: BlocProvider<AVBlocData>(
        bloc: new AVBlocData(),
        child: AVBlocPage()
      ),
    );
  }
}