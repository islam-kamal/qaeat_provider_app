import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/Auth/Login/salonic_login.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/Service/add_service.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/Utils/show_toast.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/models/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_service.dart';

class AllServices extends StatefulWidget {
  @override
  _AllServicesState createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  ServicesResponse ress = ServicesResponse();
  bool isLoading = true;
  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/services/AllSalonService", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = ServicesResponse.fromJson(json.decode(response.toString()));
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
    streemListner(context);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () {
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
              (Route<dynamic> route) => false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(" الخدمات ",style: TextStyle(color: Colors.white),),
            leading:  InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                        (Route<dynamic> route) => false);
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.white,),
            ),

          ),
          body: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddService()));
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        "اضافة خدمة",
                        style: TextStyle(
                            fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.add_circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              isLoading == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 200),
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : ress.salonServices == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 200),
                          child: Center(
                            child: Text("لا توجد أي خدمات مضافة حتى الآن"),
                          ),
                        )
                      : AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ress.salonServices.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 300.0,
                                  child: FadeInAnimation(
                                    child: serviceRow(
                                        ress.salonServices[index].name,
                                        ress.salonServices[index].id,
                                        ress.salonServices[index].price, index),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceRow(String serviceName, int id, int price , int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${serviceName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 15,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${price} ريال ",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditService(
                              services:ress.salonServices[index] ,
                            )));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.edit,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("deleetingg");
                      delete_service(id);
                    },
                    child: Icon(
                      Icons.delete,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void delete_service(int id) async {
    showLoadingDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "id": id,
    });
    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/services/destroy", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: "تم حذف الخدمة بنجاح",
          function: () {
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });
            getData();
          });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

}
