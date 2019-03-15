import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      theme: new ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home:  new MainPage(),
    );
  }
}



