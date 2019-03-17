import 'package:flutter/material.dart';
import 'music_page_search.dart';
import 'music_file.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_work/model/scp_model.dart';
class MusicPage extends StatefulWidget{
  final MusicFileModel songModel;
  MusicPage({@required this.songModel});
  @override
  _MusicPageState createState()=>_MusicPageState(songModel: songModel);
}
class _MusicPageState extends State<MusicPage>{
  final MusicFileModel songModel;
  _MusicPageState({@required this.songModel});
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
      body: ScopedModel<MusicFileModel>(
             model: songModel,
             child: SongList(songModel: songModel,),
           )
    );
  }

}
