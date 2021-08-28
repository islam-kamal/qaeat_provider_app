import 'dart:convert';

import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: selectedPageIndex,
            showElevation: true,
            itemCornerRadius: 100,
            curve: Curves.easeIn,
            backgroundColor: QaeatColor.white_color,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            containerHeight: MediaQuery.of(context).size.width * 0.13,
            onItemSelected:  _onItemTapped,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: Icon(
                  Icons.house,
                  color: selectedPageIndex==0? QaeatColor.white_color : QaeatColor.black_color,
                ),
                title: Text("الرئيسية",style: TextStyle(color: QaeatColor.white_color),),
                activeColor: QaeatColor.primary_color,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(
                  Icons.receipt_long_outlined,
                  color: selectedPageIndex==1? QaeatColor.white_color : QaeatColor.black_color,

                ),
                title: Text("طلباتى",style: TextStyle(color: QaeatColor.white_color)),
                activeColor: QaeatColor.primary_color,
                textAlign: TextAlign.center,

              ),

              BottomNavyBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: selectedPageIndex==2? QaeatColor.white_color : QaeatColor.black_color,

                ),/*Image(
              image: AssetImage('images/home/bell.png'),
              color: widget.index==2? QaeatColor.white_color : QaeatColor.black_color,
            ),*/
                title: Text(
                  "الاشعارات",style: TextStyle(color: QaeatColor.white_color),
                ),
                activeColor: QaeatColor.primary_color,
                textAlign: TextAlign.center,

              ),
              BottomNavyBarItem(
                icon:Icon(
                  Icons.settings,
                  color: selectedPageIndex==3? QaeatColor.white_color : QaeatColor.black_color,
                ), /*Image(
              image: AssetImage('images/home/notification.png',),
              color: widget.index==3? QaeatColor.white_color : QaeatColor.black_color,
            ),*/
                title: Text( "الاعدادت",style: TextStyle(color: QaeatColor.white_color)),
                activeColor:QaeatColor.primary_color,
                textAlign: TextAlign.center,
              ),

              BottomNavyBarItem(
                title: Text( "المزيد",style: TextStyle(color: Colors.white)),
                icon: Icon(
                  Icons.menu,
                  color: selectedPageIndex==4? Colors.white : QaeatColor.black_color,
                ),
                /*Image(
              image: AssetImage('images/home/home.png'),
              color: widget.index==4? Colors.white : QaeatColor.black_color,
            ),*/

                activeColor:QaeatColor.primary_color,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          body: pages[selectedPageIndex]),
    );
  }
}
