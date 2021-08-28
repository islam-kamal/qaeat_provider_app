import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/Utils/show_toast.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/orders/new_order.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/models/orders_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_bar.dart';

class NewOrders extends StatefulWidget {
  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: ListView(

          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CustomAppBar(
              titel: "الطلبات",

            ),
            Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 1),
                  isScrollable: true,
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Theme.of(context).primaryColor,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 15),
                      child: Center(child: Text("طلبات جديدة")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 15),
                      child: Center(child: Text("طلبات المقبولة")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      child: Center(child: Text("طلبات مكتملة")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      child: Center(child: Text("طلبات مرفوضة")),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height-250 ,
              child: TabBarView(
                children: [
                  NewOrderView(
                    status: "new",
                  ),NewOrderView(
                    status: "pending",
                  ),
                  NewOrderView(
                    status: "done",
                  ),
                  NewOrderView(
                    status: "refuse",
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

  Widget order(String type, int id, String date, String time, String employee,
      String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.8,
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
              Row(
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
                  Container(
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
                  )
                ],
              ),
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
                          "${title}",
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
                          Container(
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
                          Container(
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
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
