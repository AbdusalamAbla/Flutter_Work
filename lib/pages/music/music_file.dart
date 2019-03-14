import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';


class SongList extends StatefulWidget{
@override
_SongListState createState()=>_SongListState();
}
class _SongListState extends State<SongList> {
  bool isFounding=false;
  @override
  Widget build(BuildContext context) {
    return getBody();

  }
   
  //Variables
  List<FileSystemEntity> _songList=[];
  int count=0;
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
  if(_songList.length!=0){
    return Scrollbar(
      child: ListView.builder(
        controller: controller,
        itemCount: _songList.length!=0?_songList.length:1,
        itemBuilder: (BuildContext context,int index){
            return buildListViewItem(_songList[index]);
        }
    )
  );
  }else if(!isFounding){return
        Center(
          child: new RaisedButton(child: Text('查找本地歌曲'),
        onPressed: ((){
            setState(() {isFounding=true; });
              _initSongList();
          }),
         ),
        );
  }else{
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

Future<void> _initSongList() async {
      var path=(await getExternalStorageDirectory()).path;
    List result = await compute(_findFileInDir, path);
    setState(() {
      _songList = result;
      isFounding=false;
    });
    
  }

//Stati method for running on other isolates.
static List _findFileInDir(String path){

    List<FileSystemEntity> fileList=[];
    List<FileSystemEntity> songList=[];
      Directory directory=Directory(path);
     fileList.addAll(directory.listSync());
     for (int index=0;index<fileList.length;index++) {
       var file=fileList[index];
       if (!FileSystemEntity.isFileSync(file.path)&&basename(file.path).substring(0,1)!='.') {
         fileList.addAll(Directory(file.path).listSync());
         fileList.removeAt(index);
         index--;
       }
     }
     
      for (FileSystemEntity file in fileList) {
        var listStr= basename(file.path).split('.');
        if (listStr.length!=2) {
          continue;
        }else{
         switch (listStr[1]) {
           case 'mp3':
           case 'MP3':
           if (!(File(file.resolveSymbolicLinksSync()).lengthSync()<1048576)) {
             songList.add(file);
           }   break;
           default:break;
         }
        }
      }
      return songList; 
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
