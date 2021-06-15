/*
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/models/home_page.dart';

class EmpCommentsView extends StatefulWidget {
  final List<Employees> employees;

  const EmpCommentsView({Key key, this.employees}) : super(key: key);

  @override
  _EmpCommentsViewState createState() => _EmpCommentsViewState();
}

class _EmpCommentsViewState extends State<EmpCommentsView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("قائمة التعليقات"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.employees.length,
                itemBuilder: (context, index) {
                  return EmployeesRow(index);
                })),
      ),
    );
  }

  Widget EmployeesRow(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "اسم الموظف :  ${widget.employees[index].name}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Divider(),
        widget.employees[index].employeeRate.isEmpty
            ? Center(
          child: Text("لا توجد تعليقات للموظف حتى الان"),
        )
            :  Container(
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
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "التعليقات",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "التقيم",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                    itemCount: widget.employees[index].employeeRate.length,
                    itemBuilder: (context, empIndex) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              "${widget.employees[index].employeeRate[empIndex].user.name}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Center(
                              child: Text(
                                "${widget.employees[index].employeeRate[empIndex].comment ?? ""}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 9,
                            child: Center(
                              child: Text(
                                  "${widget.employees[index].employeeRate[empIndex].value ?? "0"}"),
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
}
*/
