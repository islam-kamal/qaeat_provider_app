import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/Utils/show_toast.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/models/bouns_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BounsList extends StatefulWidget {
  @override
  _BounsListState createState() => _BounsListState();
}

class _BounsListState extends State<BounsList> {
  BounsListResponse ress = BounsListResponse();
  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "salon_id": preferences.getInt("id")
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/orders/get-list-bonus", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = BounsListResponse.fromJson(json.decode(response.toString()));
        isLoading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  NotificationMethos methos = NotificationMethos();

  streemListner(BuildContext contetext) {
    methos.appPushNotifications.notificationSubject.stream.listen((data) {
      print("------------------XXXXXX-------- $data");
      setState(() {
        methos.showToast(data['notification']['title'],
            data['notification']['body'], contetext, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contetext) => MainPage(
                        index: 2,
                      )));
        });
      });
    });
  }

  @override
  void initState() {
    streemListner(
      context,
    );
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          children: [
            CustomAppBar(
              titel: "تصدير عمولة التطبيق",
              icon: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 15,
                        child: Text(
                          "#1",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text(
                          "قيمة الطلب",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: Center(
                          child: Text(
                            "عمولة التطبيق",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            "التاريخ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        "/",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 8,
                        child: Text(
                          "الوقت",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ress.data.bouns.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 300.0,
                      child: FadeInAnimation(
                        child: orderRow(
                            ress.data.bouns[index].id,
                            ress.data.bouns[index].services.isEmpty
                                ? 0
                                : ress.data.bouns[index].services[0].price,
                            ress.data.bouns[index].services.isEmpty
                                ? "0"
                                : ress.data.bouns[index].services[0].bonus,
                            ress.data.bouns[index].date,
                            ress.data.bouns[index].time),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderRow(
      int id, int total, String commition, String date, String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 15,
                child: Center(
                  child: Text(
                    "${id}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Center(
                  child: Text(
                    "${total} ريال",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                child: Center(
                  child: Text(
                    "${commition} ريال",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4.4,
                child: Center(
                  child: Text(
                    "${date}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "/",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 8,
                child: Center(
                  child: Text(
                    "${time}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
