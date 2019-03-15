import 'package:scoped_model/scoped_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
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
  List<FileSystemEntity> _songList=[];
  bool isFounding=false;
  List<FileSystemEntity> get songList=>_songList;

  void initSongList() async{
    isFounding=true;
    notifyListeners();
   var path=(await getExternalStorageDirectory()).path;
   _songList = await compute(_findFileInDir, path);
   isFounding=false;
   notifyListeners();
  }

  static List<FileSystemEntity> _findFileInDir(String path){

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
}