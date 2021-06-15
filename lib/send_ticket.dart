import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomWidgets/ErrorDialog.dart';
import 'Utils/NetWorkHelper.dart';
import 'customer_service.dart';

class CustomerServiceComplain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomerServiceComplain_state();
  }
}

class CustomerServiceComplain_state extends State<CustomerServiceComplain> {
  final _formKey = GlobalKey<FormState>();
  String token;
  int id;

  TextEditingController _emailAddress = new TextEditingController();
  TextEditingController _PhoneNumber = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _message = new TextEditingController();
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'قم بكتابه البريد الالكترونى!';
    } else {
      return null;
    }
  }

  getFromCash() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      token = perf.getString("token");
      id = perf.getInt("id");
    });
  }
@override
  void initState() {
  getFromCash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الدعم الفنى',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: QaeatColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Container(
                padding: EdgeInsets.only(top: 10),
                child: Form(
                  key: _formKey,
                  child: new Container(
                    padding: EdgeInsets.only(right: 10, left: 5, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'الاسم بالكامل',
                                style: style,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                              child: new Container(
                                child: TextFormField(
                                  controller: _username,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    hintText: 'اكتب اسمك هنا',
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Color(0xFFF6F6F6),
                                        )),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'قم بكتابه الاسم بالكامل اولا !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'رقم الجوال',
                                style: style,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0xFFF6F6F6),
                                    width: 1.0,
                                  ),
                                  color: Color(0xFFF6F6F6),
                                ),
                                child: new Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              '   966+',
                                              style: style,
                                            )
                                          ],
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: _PhoneNumber,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFF6F6F6),
                                          hintText: 'xxxxxxxx',
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'رقم الجوال غير صحيح!';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'البريد الالكترونى',
                                style: style,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: new Container(
                                child: TextFormField(
                                  controller: _emailAddress,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    border: InputBorder.none,
                                    hintText: 'Example@gmail.com',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFF6F6F6),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  validator: emailValidator,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              child: Text('الملاحظات', style: style),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: new Container(
                            child: TextFormField(
                              controller: _message,
                              maxLines: 4,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFF6F6F6),
                                border: InputBorder.none,
                                hintText: 'اكتب ملاحظاتك هنا..',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFF6F6F6),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'قم بادخال ملاحظاتك !';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        // use Builder to solve Scaffold.of() called with a context that does not contain a Scaffold Exception
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 5),
                          child: Builder(
                            builder: (ctx) => new Container(
                                padding: EdgeInsets.only(top: 15.0, bottom: 10),
                                alignment: Alignment.center,
                                child: ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  child: RaisedButton(
                                    padding: const EdgeInsets.all(5.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(
                                        color: QaeatColor.primary_color,
                                        width: 1.0,
                                      ),
                                    ),
                                    color: QaeatColor.primary_color,
                                    child: Text(
                                      'ارسال',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        sendNewTicketToSupport(
                                            token,
                                            _username.text.trim(),
                                            _emailAddress.text.trim(),
                                            _PhoneNumber.text.trim(),
                                            _message.text.trim(),
                                            id,
                                            context);
                                      }
                                    },
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void sendNewTicketToSupport(String token, String username, String email,
      String mobile, String details, int user_id, BuildContext context) async {
    showLoadingDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(token);
    print(username);
    print(email);
    print(mobile);
    print(details);
    print(user_id);
    FormData _formData = FormData.fromMap({
      "token": token,
      'username': '${username}',
      'email': '${email}',
      'mobile': '${mobile}',
      'details': '${details}',
      'user_id':user_id,
    });
    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/tickets/store", body: _formData);
    if (response.data['status'] == true) {
      Navigator.pop(context);

      onDoneDialog(
          context: context,
          text: "تم ارسال رسالتك بنجاح",
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerServices(
                          token: preferences.getString('token'),
                          user_id: preferences.getInt('id',),
                          ticket_number: response.data['ticket']['ticket_num'],
                          ticket_details: response.data['ticket']['details'],
                        )));
          });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data['msg'].toString());
    }
  }
}
