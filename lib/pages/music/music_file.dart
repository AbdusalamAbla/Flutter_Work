import 'package:flutter/material.dart';
import 'package:flutter_work/model/scp_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_work/model/model.dart';
import 'music_playing.dart';
class SongList extends StatefulWidget{
 final MusicFileModel songModel;
 SongList({@required this.songModel});
@override
_SongListState createState()=>_SongListState(songModel);
}
class _SongListState extends State<SongList> {
  final MusicFileModel songModel;
  _SongListState(this.songModel);


  
  @override
  Widget build(BuildContext context) {
    _songList=songModel.songList;
    return getBody();

  }
   
  //Variables
  List<LocalMusic> _songList=[];
  ScrollController controller = ScrollController();
  //////////////////////////////////////////////////////////////

  @override 
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  // Named as whar it worked.
   // This method is for returning file`s size.
   

getBody() {
  if(songModel.isFounding==false&&_songList.length!=0){
    return ScopedModelDescendant<MusicFileModel>(
      builder: (context,child,songModel){
        return Scrollbar(
      child: ListView.builder(
        controller: controller,
        itemCount: _songList.length!=0?_songList.length:1,
        itemBuilder: (BuildContext context,int index){
            return buildListViewItem(_songList[index]);
        }),

        );
      }
    );
  }else if (songModel.isFounding==true){
    new Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        _songList=songModel.songList;
      });
    });
    return  new Center(child: new CircularProgressIndicator());
  }else if (songModel.songList.length<1) {
    return new Center(
      child: RaisedButton(onPressed: (){
      songModel.getSongListfromLocal();
      setState(() {
       _songList=songModel.songList; 
      });
    },child: Text('获取本地歌曲'),),
    );
  }
}



  buildListViewItem(LocalMusic music){
    return  Column(
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                    return new MusicPlay(music: music);
                  })),
            title: Row(
              children: <Widget>[
                Expanded(child: Text(  '${music.title}'  )),//file.path.substring(file.parent.path.length + 1)
                 Container()   
              ],
            ),
            subtitle:  Text(
                    '${music.modify}  ${music.size}',
                    style: TextStyle(fontSize: 12.0),
                  ),
          trailing:  null ,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Divider(
              height: 1.0,
            ),
          )
        ],
        
      );
  }
}
