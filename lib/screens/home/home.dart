import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_tabs/create_tab.dart';
import 'home_tabs/profile_tab.dart';
import 'home_tabs/vote_tab.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPageIndex = 0;
  int _previousIndex = 0;

  refresh() {
    setState(() {
      _selectedPageIndex = _previousIndex;
    });
  }

  _onItemTapped(int index) {
    setState(() {
      _previousIndex = _selectedPageIndex;
      _selectedPageIndex = index;
    });
  }

  pageCaller(int index) {
    switch (index) {
      case 0:
        return VoteTab();
      case 1:
        return CreateTab(callback: refresh);
      case 2:
        return ProfileTab();
    }
  }

  List<BottomNavigationBarItem> tabsItems = [
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.voteYea,
      ),
      label: "Vote",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.plusCircle,
      ),
      label: "Create",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.userCircle,
      ),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _selectedPageIndex != 1
          ? BottomNavigationBar(
              iconSize: 28,
              backgroundColor: Color(0xFFffd6da),
              selectedItemColor: Color(0xFFdc8c97),
              onTap: _onItemTapped,
              currentIndex: _selectedPageIndex,
              items: tabsItems,
            )
          : null,
      body: pageCaller(_selectedPageIndex),
    );
  }
}
