import 'package:flutter/material.dart';

class CloudPage extends StatefulWidget{
  @override
  _CloudPageState createState()=>_CloudPageState();

}
class _CloudPageState extends State<CloudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的服务器'),
      ),
      body: Center(
        child: Text('服务器文件列表',style: Theme.of(context).textTheme.display1,),
      ),
    );
  }
  
}