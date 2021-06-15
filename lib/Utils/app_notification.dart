import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppPushNotifications {
  FirebaseMessaging _firebaseMessaging;
  GlobalKey<NavigatorState> navigatorKey;

//  MainModel model = MainModel();

  static StreamController<Map<String, dynamic>> _onMessageStreamController =
  StreamController.broadcast();
  static StreamController<Map<String, dynamic>> _streamController =
  StreamController.broadcast();

  static final Stream<Map<String, dynamic>> onFcmMessage =
      _streamController.stream;

  void notificationSetup(GlobalKey<NavigatorState> navigatorKey) {
    _firebaseMessaging = FirebaseMessaging();
    this.navigatorKey = navigatorKey;
    print("===================================");
    requestPermissions();
    getFcmToken();
    notificationListeners();
  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void requestPermissions() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
  }

  Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('msgToken', await _firebaseMessaging.getToken());
    print('firebase token => ${await _firebaseMessaging.getToken()}');
    print("_____________" + await _firebaseMessaging.getToken());
    return await _firebaseMessaging.getToken();
  }

  void notificationListeners() {
    _firebaseMessaging.configure(
        onMessage: _onNotificationMessage,
        onResume: _onNotificationResume,
        onLaunch: _onNotificationLaunch);
  }

  Future<dynamic> _onNotificationMessage(Map<String, dynamic> message) async {
    print("------- ON MESSAGE -------5555555----- $message");
//    notificationAction(message["data"]["title"]);
// _notificationSubject.add(message);
    _onMessageStreamController.add(message);
  }

  Future<dynamic> _onNotificationResume(Map<String, dynamic> message) async {
//    navigatorKey.currentState.push(PageRouteBuilder(pageBuilder: (_, __,___) {
//      print(message["data"]["status"]);
////      return  Notifications();
//    }));
    print("------- ON RESUME ------66666666------ $message");
// _notificationSubject.add(message);
//    notificationAction(message["data"]["title"]);
    _streamController.add(message);
  }

  Future<dynamic> _onNotificationLaunch(Map<String, dynamic> message) async {
    print("------- ON LAUNCH -----7777777777777------- $message");
// _notificationSubject.add(message);
    _streamController.add(message);
//    notificationAction(message["notification"]["title"]);

//    navigatorKey.currentState.push(PageRouteBuilder(pageBuilder: (_, __,___) {
//    return  Notifications();
//    }));
  }

  void killNotification() {
    _onMessageStreamController.close();
    _streamController.close();
  }

}
