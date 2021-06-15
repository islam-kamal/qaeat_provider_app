import 'dart:async';
import 'package:Qaeat_Provider/Auth/Login/salonic_login.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/components/animated_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<Timer> _loadData() async {
    return new Timer(Duration(seconds: 4), _onDoneLoading);
  }

  _onDoneLoading() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("msgToken");
    preferences.getString("token") != null
        ? print(preferences.getString("token"))
        : preferences.setBool("logged", false);

    preferences.getBool("logged") == false
        ? Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SalonicLogin(),
        ),
            (Route<dynamic> route) => false)
        : Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
            (Route<dynamic> route) => false);
  }

  Widget page_header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'أهلا بك !',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'مرحبا بك مجددا معنا',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Cairo', fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Image(
      image: AssetImage('assets/images/qaeat_splash.png'),
      fit: BoxFit.fill,
    );
  }
}
