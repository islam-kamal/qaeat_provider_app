import 'dart:convert';

import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/home_page.dart';
import 'package:Qaeat_Provider/components/drawer_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/Helper/pic_location.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/Utils/show_toast.dart';
import 'package:Qaeat_Provider/components/CustomButton.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/components/custom_text_field.dart';
import 'package:Qaeat_Provider/models/salon_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_bar.dart';

class Setting extends StatefulWidget {
  final Function callback;
final String route;
  const Setting({Key key, this.callback, this.route}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int issCash = 0;
  bool house = true;
  bool reservation = true;
  String username, address, name, update_password, update_password_confirmation, email , hall_max_number;
  double lat, lng;
  var result = [];

  Future goToLocationScreen() async {
    result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseLocation()));
    setState(() {
      address = result[0];
      lat = result[1];
      lng = result[2];
    });
  }

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
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "الاعدادت",
              style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
            ),
          ),
          actions: [
         widget.route == 'drawer'?   InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
            ) : Container()
          ],
          backgroundColor: QaeatColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child:ListView(
          children: [
 /*           CustomAppBar(
              titel: "الاعدادات",
              icon: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),*/
            isLoading == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : editGeralData()
          ],
        ),
      ),

    );
  }

  Widget editGeralData() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Text(
          "اسم الحساب",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          onChanged: (String val) {
            setState(() {
              username = val;
            });
            print(username);
          },
          label: "${ress.salon.name}",
        ),
        Text(
          "اسم المستخدم",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          onChanged: (String val) {
            setState(() {
              name = val;
            });

            print(name);
          },
          label: "${ress.salon.username}",
        ),
        Text(
          "البريد الالكتروني",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          onChanged: (String val) {
            setState(() {
              email = val;
            });

            print(email);
          },
          label: "${ress.salon.email}",
        ),
        Text(
          "كلمة المرور",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          onChanged: (String val) {
            setState(() {
              update_password = val;
            });

            print(update_password);
          },
          secureText: true,
          label: "كلمة المرور",
        ),
        Text(
          "تاكيد كلمة المرور",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          onChanged: (String val) {
            setState(() {
              update_password_confirmation = val;
            });

            print(update_password_confirmation);
          },
          secureText: true,
          label: "تاكيد كلمة المرور",
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "طريقة الدفع",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  issCash = 0;
                });
              },
              child: Row(
                children: [
                  issCash == 0
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "كاش",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  issCash = 1;
                });
              },
              child: Row(
                children: [
                  issCash == 1
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "اونلاين",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  issCash = 2;
                });
              },
              child: Row(
                children: [
                  issCash == 2
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "كلاهما",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
   /*     SizedBox(
          height: 10,
        ),
        Text(
          "خدمات المنزل",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  house = !house;
                });
              },
              child: Row(
                children: [
                  house == true
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_unchecked),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "متاح",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  house = !house;
                });
              },
              child: Row(
                children: [
                  house == false
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_unchecked),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "غير متاح",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),*/
        SizedBox(
          height: 10,
        ),
        Text(
          "اختيار الحجز",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  reservation = !reservation;
                });
              },
              child: Row(
                children: [
                  reservation == true
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_unchecked),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "متاح",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  reservation = !reservation;
                });
              },
              child: Row(
                children: [
                  reservation == false
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_unchecked),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "غير متاح",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        editItemRow(
            lable: "تغير الموقع ",
            input: address ?? "${ress.salon.address}",
            function: () => goToLocationScreen()
        ),

    ress.salon.categoryId == 1? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(10),
              child:   Text("عدد الافراد"),
            ),
            CustomTextField(
              onChanged: (String val) {
                setState(() {
                  hall_max_number = val;
                });
                print('hall_individuals : ${hall_max_number}');
              },
              inputType: TextInputType.number,
              label: "${ress.salon.hallMaxNumber==null ? 100 : ress.salon.hallMaxNumber}",
            ),
          ],
        ): Container(),
   Padding(padding: EdgeInsets.only(top: 20),
   child:      CustomButton(
     onButtonPress: () {
       editData();
     },
     text: "حفظ التعديل",
   ),)
      ],
    );
  }

  Widget editItemRow({String lable, String input, Function function}) {
    return InkWell(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "${lable}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex:8,
                    child:     Text(
                      "${input}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex:1,
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ) ),
              ],
            ),),
          ),
        ],
      ),
    );
  }

  void editData() async {
    showLoadingDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(username);
    print(email);
    print(update_password);
    print(update_password_confirmation);
    print(name);
    print(address);
    print(lat);
    print(lng);
    print(house == true ? "house" : "salon");
    print(reservation == true ? "yes" : "no");
    print(issCash == 0 ? "cash" : issCash == 0 ? "visa" : "Both");

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "id": preferences.getInt("id"),
      "username": name,
      "name": username,
      "update_password ": update_password,
      "update_password_confirmation": update_password_confirmation,
      "email ": email,
      "payment": issCash == 0 ? 0 : issCash == 1 ? 1 : 1,
      //"home_service": house == false ? 0 : 1,
      //"booking": reservation == false ? 0 : 1,
      "Latitude": lat,
      "Longitude": lng,
      "address": address,
      "hall_max_number" : hall_max_number
    });
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("admin/salons/update", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: "تم تعديل البيانات بنجاح",
          function: () {
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });
            getData();
          });
    } else {
      print("ERROR");
      Navigator.pop(context);
      onDoneDialog(context: context, text: "تم تعديل البيانات بنجاح");
      errorDialog(context: context, text: response.data["msg"]);
      print(response.data.toString());
    }
  }
}
