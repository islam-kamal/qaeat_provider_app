import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:Qaeat_Provider/Auth/splash.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';

import 'Utils/app_notification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();

  @override
  void initState() {
    super.initState();
    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });
    Future<PermissionStatus> permissionStatus =
    NotificationPermissions.getNotificationPermissionStatus();
    permissionStatus.then((status) {
      print("======> $status");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Salonic",
        debugShowCheckedModeBanner: false,
        home: Splash(),
        theme: ThemeData(
          //------------------make iphone back with swipe-----------------
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          primaryColor: Color(0xFFFE6F8F),
          accentColor: Color(0xFFFE6F8F),
          backgroundColor: Color(0xFFFAFAFA),

          fontFamily: 'Cairo',
        ));
  }
}
