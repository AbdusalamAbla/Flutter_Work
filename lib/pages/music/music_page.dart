import 'package:flutter/material.dart';
import 'music_page_search.dart';
import 'music_file.dart';
class MusicPage extends StatefulWidget{
  @override
  _MusicPageState createState()=>_MusicPageState();
}
class _MusicPageState extends State<MusicPage>{
  
  int _lastIntegerSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ],
      ),
      body: SongList()
    );
  }

}
