import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/Auth/splash.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Service/allSalonServices.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/app_commition/appCommiton.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/setting.dart';
import 'package:Qaeat_Provider/call%20us/call_us.dart';
import 'package:Qaeat_Provider/images/images.dart';
import 'package:Qaeat_Provider/models/salon_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../send_ticket.dart';

class MyDrawer extends StatefulWidget {
  final String name, image;

  const MyDrawer({Key key, this.name, this.image}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String name, image;

  SalonResponse ress = SalonResponse();
  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
    });
    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/salons/get-salon", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = SalonResponse.fromJson(json.decode(response.toString()));
        name = ress.salon.name;
        image = ress.salon.logo;
        print("image : ${image}");
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            isLoading == true
                ? Container(
                    width: 100,
                    height: 100,
                    child: Center(
                        child: SpinKitCircle(
                      color: Colors.white,
                    )))
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:image ==null ? AssetImage('assets/images/qaeat_splash.png')
                                    : NetworkImage(image),
                                  //NetworkImage(image),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      radius: 55,
                      backgroundColor: Colors.white,
                    ),
                  ),
            isLoading == true
                ? SizedBox()
                : Center(
                    child: Text(
                      "مرحبا ${name}",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1,),

            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: index == 0
                                ? item(
                                    Icon(
                                      Icons.monetization_on,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    "الحسابات", () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppCommition(),
                                        ));
                                  })
                                : index == 1
                                    ? item(
                                        Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                        "تعديل الحساب", () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Setting(
                                                      route: 'drawer',
                                                    )));
                                      })
                                    : index == 2
                                            ? item(
                                                Icon(
                                                  Icons.content_cut,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                                "الخدمات", () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllServices(),
                                                    ));
                                              })
                                            : index == 3
                                                    ? item(
                                                        Icon(
                                                          Icons.image,
                                                          size: 30,
                                                          color: Colors.black,
                                                        ),
                                                        "الصور", () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SalonImages(),
                                                            ));
                                                      })
                                                        : index == 4
                                                            ? item(
                                                                Icon(
                                                                  Icons.exit_to_app,
                                                                  size: 30,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                "تسجيل الخروج",
                                                                () {
                                                                runservice();
                                                              })
                                                            : SizedBox()),
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

  void runservice() async {
    NetworkUtil _util = NetworkUtil();
    showLoadingDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
    });

    Response response = await _util.post("admin/salons/logout", body: formData);
    if (response.data["status"] == false) {
      Navigator.pop(context);
      errorDialog(
          context: context,
          text: response.data["errNum"] == ""
              ? "حدث خطأ ما "
              : response.data["errNum"]);
    } else {
      Navigator.pop(context);
      preferences.setBool("logged", false);
      preferences.remove("token");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Splash()));
    }
  }

  Widget item(Widget icon, String lable, Function function) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    child: InkWell(
      onTap: function,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(7),
                  
                ),
                padding: EdgeInsets.all(5),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${lable}",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade200,


          )

        ],
      ),
    ),);
  }
}
