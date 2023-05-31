import 'package:app_first/login/singupmix_screen.dart';
import 'package:app_first/profile/profile.dart';
import 'package:flutter/material.dart';

import '../Products/Cart.dart';
import '../Shoppingcart.dart';
import '../chat.dart';
import '../firebase.dart';
import 'home_page.dart';
import '../map/map.dart';
import '../profile/profile_page.dart';

class HomeScreen extends StatefulWidget {
  final String id;   HomeScreen({required this.id, Key? key})       : super(key: ValueKey<String>(id));

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    String email = "${widget.id}";
    final _kTabPages = <Widget>[
      const HomePage(),




      const MyApp(),
      CartScreen(),
      ProfilePage(id:email),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
      const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'ปรึกษา'),
      const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'ตระกร้า'),
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