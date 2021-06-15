import 'dart:convert';

import 'package:Qaeat_Provider/Auth/Login/salonic_login.dart';
import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomBottomSheet.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomButton.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomTextFormField.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/models/cities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalonSignUp extends StatefulWidget {
  @override
  _SalonSignUpState createState() => _SalonSignUpState();
}

class _SalonSignUpState extends State<SalonSignUp> {
  String name, username, password, email, city_name, address, reCapcha;
  int city_id;


  CitiesResponse ress = CitiesResponse();

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
    });


    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/cities/getAllCities", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = CitiesResponse.fromJson(json.decode(response.toString()));
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
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'أنشاء حساب جديد',
              style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
            ),
          ),
          actions: [
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context)=> SalonicLogin()));
              },
              child: Icon(Icons.arrow_forward_ios),
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
          child:ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  username = val;
                });
                print(username);
              },
              hint: " اسم المستخدم",
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  name = val;
                });
                print(name);
              },
              hint: "اسم المركز",
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  address = val;
                });
                print(address);
              },
              hint: "العنوان",
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  email = val;
                });
                print(email);
              },
              hint: "البريد الإلكتروني",
            ),
            city_conyainer(),
            CustomTextField(
              value: (String val) {
                setState(() {
                  password = val;
                });
                print(password);
              },
              hint: "كلمة المرور",
              inputType: TextInputType.emailAddress,
              secureText: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            InkWell(
              onTap: () {
//                print(_username.value);
//                print(_password.value);
                runservice();
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
              },
              child: CustomButton(
                raduis: 10,
                text: "تسجيل ",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page_header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Center(
                      child: Text(
                        'أهلا بك !',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 20),
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.centerLeft,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'مرحبا بك مجددا معنا',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Cairo', fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void runservice() async {
    print(username);
    print(name);
    print(email);
    print(address);
    print(city_id);
    print(password);
    if (username == null || username.length < 3) {
      errorDialog(context: context, text: "يرجي ادخال الاسم بشكل صحيح");
    } else if (name == null) {
      errorDialog(context: context, text: "يرجي ادخال اسم المركز بشكل صحيح");
    } else if (email == null) {
      errorDialog(
          context: context, text: "يرجي ادخال البريد الالكتروني بشكل صحيح");
    } else if (address == null) {
      errorDialog(context: context, text: "يرجي ادخال العنوان بشكل صحيح");
    } else if (city_id == null) {
      errorDialog(context: context, text: "يرجي اختيا المدينة");
    } else if (password == null || password.length < 8) {
      errorDialog(context: context, text: "يرجي ادخال كلمة مرور لا تقل عن 8 احرف");
    } else {
      NetworkUtil _util = NetworkUtil();
      showLoadingDialog(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "username": username,
        "name": name,
        "address": address,
        "city_id": city_id,
        "email": email,
        "password": password,
        "reCAPTCHA": "on",
        "deviceToken": preferences.getString("msgToken")

      });

      Response response =
          await _util.post("admin/salons/signup", body: formData);
      if (response.data["status"] == false) {
        Navigator.pop(context);
        errorDialog(context: context, text: response.data["msg"]);
      } else {
        Navigator.pop(context);

        preferences.setBool("logged", true);
        preferences.setString(
            "token", "${response.data["salons"]["access_token"]}");

        preferences.setInt("id", response.data["salons"]["id"]);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
  }

  Widget city_conyainer() {
    return InkWell(
      onTap: () {
        CustomSheet(
            context: context,
            widget: ListView.builder(
                itemCount: ress.cities.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        city_id = ress.cities[index].id;
                        city_name = ress.cities[index].name;
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [Text(ress.cities[index].name), Divider()],
                    ),
                  );
                }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              city_name ?? "المدينة",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 12),
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: city_id == null
                      ? Colors.grey
                      : Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: double.infinity,
        ),
      ),
    );
  }
}
