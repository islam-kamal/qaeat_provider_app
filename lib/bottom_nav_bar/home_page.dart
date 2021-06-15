import 'dart:convert';

import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/Service/allSalonServices.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/Utils/show_toast.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/comments_view.dart';
import 'package:Qaeat_Provider/components/image_app_bar.dart';
import 'package:Qaeat_Provider/images/images.dart';
import 'package:Qaeat_Provider/models/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'emp_comments.dart';

class HomeScreenPage extends StatefulWidget {
  final Function callback;

  const HomeScreenPage({Key key, this.callback}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  HomePageResponse ress = HomePageResponse();
  bool isLoading = true;
  List<Order> pendingOrders = List();
  List<Order> doneOrders = List();

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/orders/get-home-page", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = HomePageResponse.fromJson(json.decode(response.toString()));
        print("ress : ${ress.hall}");
        isLoading = false;
      });
      for (int i = 0; i < ress.hall[0].order.length; i++) {
        if (ress.hall[0].order[i].status == 0) {
          setState(() {
            pendingOrders.add(ress.hall[0].order[i]);
          });
        } else {
          setState(() {
            doneOrders.add(ress.hall[0].order[i]);
          });
        }
      }
      print(json.encode(pendingOrders));
      print(json.encode(doneOrders));
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  void ChangeStatus(int order_id, int user_id, int status) async {
    showLoadingDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "id": order_id,
      "user_id": user_id,
      "status": status
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/orders/change-order-status", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      Navigator.pop(context);
      onDoneDialog(
          text: "تم تغير حالة الطلب بنجاح",
          context: context,
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
      Navigator.pop(context);
      errorDialog(text: response.data["msg"], context: context);
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'الرئيسية',
            style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
          ),
        ),
        backgroundColor: QaeatColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          isLoading == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                       child: Column(
                         children: <Widget>[
                           Text("اجمالي الربح"),
                           Text(
                             "${ress.hall[0].hallTotalRevenue} ريال",
                             style: TextStyle(fontWeight: FontWeight.bold),
                           ),
                         ],
                       ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: <Widget>[
                            Text("عمولة التطبيق"),
                            Text(
                              "${ress.hall[0].appTotalRevenue} ريال",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ),
                    ],
                  ),
                ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllServices(),
                        ));
                  },
                  child: Container(
                   width: MediaQuery.of(context).size.width/4,
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:5 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.content_cut,
                            size: 35,
                            color: Colors.white,
                          ),

                          Text(
                            "الخدمات",
                            style: TextStyle(color: Colors.white ,fontSize: 16 ,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               /* InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Empolyee(),
                        ));
                  },
                  child: Container(
                   width: MediaQuery.of(context).size.width/4,
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:5 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.people,
                            size: 35,
                            color: Colors.white,
                          ),

                          Text(
                            "الموظفين",
                            style: TextStyle(color: Colors.white ,fontSize: 16 ,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalonImages(),
                        ));
                  },
                  child: Container(
                   width: MediaQuery.of(context).size.width/4,
                    height: MediaQuery.of(context).size.height/7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:5 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.image,
                            size: 35,
                            color: Colors.white,
                          ),

                          Text(
                            "الصور",
                            style: TextStyle(color: Colors.white ,fontSize: 16 ,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          isLoading == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : ress.hall[0].rates.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "لا توجد تعليقات ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 40,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "#1",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "الاسم",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "التعليقات",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ألمركز",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ress.hall[0].rates.length > 5
                                    ? 5
                                    : ress.hall[0].rates.length,
                                itemBuilder: (context, index) {
                                  return reviewRow(
                                      ress.hall[0].rates[index].id,
                                      ress.hall[0].rates[index].user.name,
                                      ress.hall[0].rates[index].comment,
                                      ress.hall[0].rates[index].value
                                          .toDouble());
                                }),
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                      )),
       /*   SizedBox(
            height: MediaQuery.of(context).size.height/17,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "تعليقات الموظفين",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmpCommentsView(
                                  employees: ress.hall[0].employees,
                                )));
                  },
                  child: Text(
                    "عرض الكل ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          isLoading == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : ress.hall[0].employees.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "لا توجد  تعليقات للموظفين ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ress.hall[0].employees.length > 3
                              ? 3
                              : ress.hall[0].employees.length,
                          itemBuilder: (context, index) {
                            return EmployeesRow(index);
                          })),*/
        ],
      ),
    );
  }

  Widget penndingOrders(int id, String status, String userName, int userId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 7,
              child: Center(
                child: Text(
                  "#${id}",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              child: Center(
                child: Text(
                  "معلق",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5,
              child: Center(
                child: Text(
                  "${userName}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ChangeStatus(id, userId, 1);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6.5,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    "قبول",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
            Text(
              "/",
              style: TextStyle(
                  color: Colors.grey[200], fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                ChangeStatus(id, userId, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width / 6.5,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      "رفض",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget orderRow(
      int id, int status, String userName, String time, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 15,
              child: Center(
                child: Text(
                  "${id}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              child: Center(
                child: Text(
                  status == 1
                      ? "مقبول"
                      : status == 2
                          ? "مرفوض"
                          : status == 3 ? "ملغية" : "مكتملة",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5,
              child: Center(
                child: Text(
                  "${userName}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5,
              child: Center(
                child: Text(
                  "${date}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Text(
              "/",
              style: TextStyle(
                color: Colors.grey[200],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              child: Center(
                child: Text(
                  "${time}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget reviewRow(int id, String userName, String comment, double Rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 10,
              child: Center(
                child: Text(
                  " #${id}",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5,
              child: Center(
                child: Text(
                  "${userName}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  comment ?? "لا تعليق",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              child: Center(
                  child: Text(
                "${Rate}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

/*
  Widget EmployeesRow(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "اسم الموظف :  ${ress.salon[0].employees[index].name}",
        //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        // ),
        Divider(),
        ress.hall[0].employees[index].employeeRate.isEmpty
            ? Center(
                child: Text("لا توجد تعليقات للموظف حتى الان"),
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "اسم المستخدم ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "التعليقات",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "التقيم",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ress.salon[0].employees[index].employeeRate
                                      .length > 3 ? 3
                              : ress.salon[0].employees[index].employeeRate
                                  .length,
                          itemBuilder: (context, empIndex) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "${ress.salon[0].employees[index].employeeRate[empIndex].user.name}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Center(
                                    child: Text(
                                      "${ress.salon[0].employees[index].employeeRate[empIndex].comment ?? ""}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 9,
                                  child: Center(
                                    child: Text(
                                        "${ress.salon[0].employees[index].employeeRate[empIndex].value ?? "0"}"),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              )
      ],
    );
  }
*/
}
