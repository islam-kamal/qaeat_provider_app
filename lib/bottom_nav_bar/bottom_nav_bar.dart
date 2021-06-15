import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/more.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/new_orders.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/setting.dart';
import 'package:Qaeat_Provider/components/drawer_view.dart';
import 'package:Qaeat_Provider/models/salon_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'notifications.dart';

class MainPage extends StatefulWidget {
  final int index ;
  const MainPage({Key key, this.index}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPageIndex = 0;
  bool isBottomNavigationVisible = true;
  PageController mainPageController = PageController(initialPage: 0);
  List<Widget> pages = [
    HomeScreenPage(),
    NewOrders(),
    Notifications(),
    Setting(),
    More(),
  ];



  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 4
        ? _drawerKey.currentState.openEndDrawer()
        : setState(() {
            selectedPageIndex = index;
          });
  }
@override
  void initState() {
    if(widget.index ==null){
      setState(() {
        selectedPageIndex=0;
      });

    }else{
      selectedPageIndex =widget.index;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          endDrawer: MyDrawer(),
          key: _drawerKey,
          bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                selectedIconTheme: IconThemeData(
                    size: 26, color: Theme.of(context).primaryColor),
                unselectedIconTheme: IconThemeData(size: 20, color: Colors.grey),
                showSelectedLabels: true,
                type: BottomNavigationBarType.shifting,
                currentIndex: selectedPageIndex,
                items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text("الرئيسية",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.list,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text("الطلبات",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text("الاشعارات",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.settings,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text("الاعدادات",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text("المزيد",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
              ],
              onTap: _onItemTapped),
          body: pages[selectedPageIndex]),
    );
  }
}
