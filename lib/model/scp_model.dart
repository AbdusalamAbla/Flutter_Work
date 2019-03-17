import 'package:scoped_model/scoped_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_work/model/model.dart';
import 'package:flutter_work/service/db_service.dart';
class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() async{
    // First, increment the counter
    _counter++;

    // Then notify all the listeners.
    notifyListeners();
  }
}


class MusicFileModel extends Model {
  List<LocalMusic> _songList=[];
  bool isFounding=false;
  List<LocalMusic> get songList=>_songList;

  void initSongList()async{
      SQLServer sqlServer=new SQLServer();
      List<Map> results=await sqlServer.query();
      LocalMusic music;
      for (Map item in results) {
        music=LocalMusic.fromJson(item);
        _songList.add(music);
      }
      notifyListeners();
    }
  void getSongListfromLocal() async{
    isFounding=true;
    notifyListeners();
    DateTime time=DateTime.now();
    print(time);
    SQLServer sqlServer=new SQLServer();
    List<Map> results=await sqlServer.query();
    if (results.length<1) {
    var path=(await getExternalStorageDirectory()).path;
    _songList = await compute(_findFileInDir, path);
    // }else{

          LocalMusic music;
          for (LocalMusic item in _songList) {
            sqlServer.addLocalFile(item);
          }
    }else{
      LocalMusic music;
      for (Map item in results) {
        music=LocalMusic.fromJson(item);
        _songList.add(music);
      }
    }
    time=DateTime.now();
    print(time);
   
   isFounding=false;
   notifyListeners();
  }
  
  static List<LocalMusic> _findFileInDir(String path){

    List<FileSystemEntity> fileList=[];
    List<FileSystemEntity> songFileList=[];
    List<LocalMusic>  songList=[];
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
             songFileList.add(file);
           }   break;
           default:break;
         }
        }
      }
      for (var i = 0; i < songFileList.length; i++) {
        songList.add(new LocalMusic(
          id: i+1,
          title:songFileList[i].path.substring(songFileList[i].parent.path.length + 1),
          path: songFileList[i].path,
          modify: getFileLastModifiedTime(songFileList[i]),
          size: getFileSize(songFileList[i])));
      }
      fileList=null;
      songFileList=null;
    
      return songList; 
   }



  static getFileLastModifiedTime(FileSystemEntity file) {
    DateTime dateTime = File(file.resolveSymbolicLinksSync()).lastModifiedSync();

    String time =
        '${dateTime.year}-${dateTime.month < 10 ? 0 : ''}${dateTime.month}-${dateTime.day < 10 ? 0 : ''}${dateTime.day} ${dateTime.hour < 10 ? 0 : ''}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ''}${dateTime.minute}';
    return time;
  } 

 static getFileSize(FileSystemEntity file){
    int _fileSize=File(file.resolveSymbolicLinksSync()).lengthSync();
    if (_fileSize<1024) {
      return '${_fileSize.toStringAsFixed(2)}B';
    }else if (1024<=_fileSize&&_fileSize<1048576) {
      return '${(_fileSize/1024).toStringAsFixed(1)}KB';
    }else if(1048576<_fileSize&&_fileSize<1073741824){
      return '${(_fileSize/1024/1024).toStringAsFixed(1)}MB';
    }
  }
}