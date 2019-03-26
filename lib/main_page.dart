import 'dart:io';

import 'package:flutter/material.dart';

import 'package:simple_permissions/simple_permissions.dart';

import 'pages/all.dart';
import 'model/scp_model.dart';



import 'package:scoped_model/scoped_model.dart';
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

 

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
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

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
   final CounterModel model=CounterModel();
  @override
  void initState() {
    super.initState();
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
    
    
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
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
      body:  _pageController(_currentIndex),
      bottomNavigationBar: botNavBar,
    );
  }

 Widget  _pageController(int index){
      switch (index) {
        case 0: 
            return  ScopedModel<CounterModel>(
             model: model,
             child: AlarmPage(model: model,),
           );break;

        case 1:
            return Scaffold(
appBar: AppBar(
title: Text('空页面'),
),
            );break;
        
        case 2:return CloudPage();break;
        
        case 3:return NotesPage();break;
        
        case 4:return EventPage();break;
        
        default:break;
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

