import 'package:flutter/material.dart';
import './news/NewsHome.dart';
import './person/PersonHome.dart';

class App extends StatefulWidget {
  App({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  // 导航下标
  int _selectedIndex = 0;

  // 导航描述数组对象
  static List _pages = [
    {
      "title": "资讯列表",
      "route": NewsHome(),
      "icon": Icons.list,
    },
    {
      "title": "我",
      "route": PersonHome(),
      "icon": Icons.person,
    },
  ];

  // 导航数组
  List<BottomNavigationBarItem> navigationBarItems = [];

  @override
  void initState() {
    super.initState();
    this._buildNavigationBar();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _pages[_selectedIndex]["route"],
      bottomNavigationBar: BottomNavigationBar(
        items: navigationBarItems,
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  /*
   * 构建导航
   */
  _buildNavigationBar() {
    for (int i = 0; i < _pages.length; i++) {
      navigationBarItems.add(BottomNavigationBarItem(
        icon: Icon(_pages[i]["icon"]),
        title: Text(_pages[i]["title"]),
      ));
    }
  }
}
