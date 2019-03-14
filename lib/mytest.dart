// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'pages/all.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';
import 'bloc2.dart';
class NavigationIconView {
   final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;
  
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
       _color = color,
       _title = title,
       item = BottomNavigationBarItem(
         icon: icon,
         activeIcon: activeIcon,
         title: Text(title),
         backgroundColor: color,
       ),
       controller = AnimationController(
         duration: kThemeAnimationDuration,
         vsync: vsync,
       ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      decoration: BoxDecoration(
        border: Border.all(color: iconTheme.color, width: 2.0),
      ),
    );
  }
}

class TestDemo extends StatefulWidget {
  // static const String routeName = '/material/bottom_navigation';

  @override
  _TestDemoState createState() => _TestDemoState();
}

class _TestDemoState extends State<TestDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _getPermission();
    _initNavigationView();
  }
  
  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var pages=[
      // AlarmPage(mode,),
      AVBloc(),
      CloudPage(),
      NotesPage(),
      EventPage()];
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      //iconSize: 4.0,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      body:  pages[_currentIndex],
      bottomNavigationBar: botNavBar,
    );
  }
  Future<void> _getPermission() async{
    if (Platform.isAndroid) {
     bool _readPermission=await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
     if (!_readPermission) {
       await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
     }
     
    }
  }
  _initNavigationView(){
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.red[500],
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.music_note),
        icon: const Icon(Icons.music_note),
        title: 'Music',
        color: Colors.indigo,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.cloud),
        icon: const Icon(Icons.cloud_queue),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.turned_in),
        icon: const Icon(Icons.turned_in),
        title: 'Notes',
        color: Colors.deepOrange,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.deepPurple,
        vsync: this,
      ),
    ];

    _navigationViews[_currentIndex].controller.value = 1.0;
  }
}

