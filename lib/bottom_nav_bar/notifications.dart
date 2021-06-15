import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/models/notification_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  final Function callback;

  const Notifications({Key key, this.callback}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationsResponse ress = NotificationsResponse();
  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
    });

    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("admin/salons/get-salon-notifications",
        body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = NotificationsResponse.fromJson(json.decode(response.toString()));
        isLoading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CustomAppBar(
            titel: "الاشعارات",
          ),
          isLoading == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : ress.notifications == null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 300),
                    child: Center(child: Text(ress.msg)),
                  )
                  : AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ress.notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 300.0,
                              child: FadeInAnimation(
                                child: order(
                                    ress.notifications[index].id,
                                    ress.notifications[index].title,
                                    ress.notifications[index].message??"",
                                    ress.notifications[index].user.name??""),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  Widget order(int id, String title, String message, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    name??"",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " - ${title}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text("${message}")
            ],
          ),
        ),
      ),
    );
  }
}
