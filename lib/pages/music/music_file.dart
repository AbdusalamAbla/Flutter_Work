import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_work/model/scp_model.dart';
import 'package:scoped_model/scoped_model.dart';

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
  List<FileSystemEntity> _songList=[];
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
        })
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
  }
}



  buildListViewItem(FileSystemEntity file){
    return  Column(
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(child: Text(file.path.substring(file.parent.path.length + 1))),
                 Container()   
              ],
            ),
            subtitle:  Text(
                    '${getFileLastModifiedTime(file)}  ${getFileSize(file)}',
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
    getFileSize(FileSystemEntity file){
    int _fileSize=File(file.resolveSymbolicLinksSync()).lengthSync();
    if (_fileSize<1024) {
      return '${_fileSize.toStringAsFixed(2)}B';
    }else if (1024<=_fileSize&&_fileSize<1048576) {
      return '${(_fileSize/1024).toStringAsFixed(1)}KB';
    }else if(1048576<_fileSize&&_fileSize<1073741824){
      return '${(_fileSize/1024/1024).toStringAsFixed(1)}MB';
    }
  }
getFileLastModifiedTime(FileSystemEntity file) {
    DateTime dateTime = File(file.resolveSymbolicLinksSync()).lastModifiedSync();

    String time =
        '${dateTime.year}-${dateTime.month < 10 ? 0 : ''}${dateTime.month}-${dateTime.day < 10 ? 0 : ''}${dateTime.day} ${dateTime.hour < 10 ? 0 : ''}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ''}${dateTime.minute}';
    return time;
  } 
}
