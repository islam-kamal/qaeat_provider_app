import 'dart:convert';

import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/models/orders_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderView extends StatefulWidget {
  final String status;

  const NewOrderView({Key key, this.status}) : super(key: key);

  @override
  _NewOrderViewState createState() => _NewOrderViewState();
}

class _NewOrderViewState extends State<NewOrderView> {
  OrdersResponse ress = OrdersResponse();
  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
     "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id"),
      "status": widget.status == "new"
          ? 0
          : widget.status == "done" ? 4 : widget.status == "pending" ? 1 : 2
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/orders/get-order-status", body: formData);
    print(response.statusCode);
    print(preferences.getInt("id"));
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = OrdersResponse.fromJson(json.decode(response.toString()));
        isLoading = false;
      });
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
          text: status == 1 ? "تم  قبول الطلب بنجاح" : "تم رفض الطلب",
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoading == true
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 200),
                child: Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : ress.orders == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: Center(
                      child: Text("${ress.msg}"),
                    ),
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                      itemCount: ress.orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: 300.0,
                            child: FadeInAnimation(
                              child: order(
                                  widget.status,
                                  ress.orders[index].id,
                                  ress.orders[index].date,
                                  ress.orders[index].time,
                                 // ress.orders[index].employee.name,
                                  ress.orders[index].title,
                                  ress.orders[index].userId),
                            ),
                          ),
                        );
                      },
                    ),
                  ));
  }

  Widget order(String type, int id, String date, String time,
      String title, int user_id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        height: widget.status == "new"
            ? MediaQuery.of(context).size.height / 3
            : widget.status == "pending"
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[300])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "# ${id}",
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${date}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Text(
                    " - ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(
                    Icons.watch_later,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${time}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
             /* Row(
                children: <Widget>[
                  Icon(
                    Icons.person_add,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "المجمل  : ",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                */
             /*  Container(
                    width: 80,
                    height: 30,
                    child: Center(
                      child: Text(
                        "${employee}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]),
                  )*/
             /*
                ],
              ),*/
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      " تفاصيل  : ",
                      style: TextStyle(fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                          title ?? "لا توجد تفاصيل لهذا الطلب",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              type == "new"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              ChangeStatus(id, user_id, 1);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                child: Text(
                                  "قبول",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ChangeStatus(id, user_id, 2);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: QaeatColor.primary_color),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "رفض",
                                  style: TextStyle(
                                      color: QaeatColor.primary_color,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  :widget.status=="pending"? InkWell(
                onTap: () {
                  ChangeStatus(id, user_id, 0);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      "رفض",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ): SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
