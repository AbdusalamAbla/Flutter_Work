import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  final String title;

  LoginPage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Container(
          child: new Column(
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  print("First text field: $text");
                },
                decoration:InputDecoration(  hintText: '请输入用户名',labelText: '用户名'),
              ),
              TextField(
                  onChanged: (text) {
                    print("Second text field: $text");
                  },
                  obscureText :true,decoration:InputDecoration(  hintText: '请输入密 码',labelText: '密 码')
              )
            ],
          ),
        ),
      ),
    );
  }
}