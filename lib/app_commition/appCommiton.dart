import 'dart:convert';

import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/models/bouns_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCommition extends StatefulWidget {
  @override
  _AppCommitionState createState() => _AppCommitionState();
}

class _AppCommitionState extends State<AppCommition> {
  BounsListResponse ress = BounsListResponse();
  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("hall_id : ${preferences.getInt("id")}");
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "الحسابات",
              style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
            ),
          ),
          actions: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
            )
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
          child:SingleChildScrollView(
            child:  Column(
              children: [
                isLoading == true
                    ? Center(
                  child: SpinKitThreeBounce(
                    color: Theme.of(context).primaryColor,
                  ),
                )
                    : ress.data == null
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 200),
                  child: Center(
                      child: Text("لا توجد بيانات متاحة ")),
                )
                    : AnimationLimiter(
                  child: Container(
                    height: MediaQuery.of(context).size.height-90,
                    child: ListView.builder(
                      itemCount: ress.data.bouns.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(padding: EdgeInsets.all(10),
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            //  verticalOffset: 300.0,
                            child: FadeInAnimation(
                              child: orderRow(
                                id:  ress.data.bouns[index].id,
                                  total:  ress.data.bouns[index].totalCost,
                                  commition :  ress.data.bouns[index].totalBonus,
                                  date : ress.data.bouns[index].date,
                                  time : ress.data.bouns[index].time,
                                  user_name:  ress.data.bouns[index].user.name,
                                  payment : ress.data.bouns[index].payment,
                                  order_paid : ress.data.bouns[index].orderPaid),
                            ),
                          ),
                        ),);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget orderRow({int id, int total, int commition, String date, String time,
      String user_name, int payment, String order_paid}) {
    return Container(
          height: MediaQuery.of(context).size.height / 1.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " #   ${id}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(color: Colors.grey.shade400,),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("اسم العميل : "),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "${user_name}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade400,),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("${date}  - "),
                    ),
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("${time}"),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade400,),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("احمالي التكلفة : "),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${total}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade400,),
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("عمولة التطبيق : "),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${commition}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade400,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(" حالة الطلب : "),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        payment != "unpaid" ? "مدفوع" : "غير مدفوع",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade400,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(" حالة العمولة : "),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        order_paid == 1 ? "مدفوع" : "غير مدفوع",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
  }
}
