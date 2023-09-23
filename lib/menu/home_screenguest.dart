
import 'package:flutter/material.dart';


import '../Role_guest/guest_to_register.dart';

import 'home_pageguset.dart';

class HomeScreenguest extends StatefulWidget {
  final String id;   HomeScreenguest({required this.id, Key? key})       : super(key: ValueKey<String>(id));

  @override
  State<StatefulWidget> createState() => _HomeScreenguestState();
}

class _HomeScreenguestState
    extends State<HomeScreenguest> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {

    final _kTabPages = <Widget>[
      const HomePageguest(),




      const forceregister(),
      const forceregister(),
      const forceregister(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
      const BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'ปรึกษา'),
      const BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'ตระกร้า'),
      const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'บัญชี'),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}