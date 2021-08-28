import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/Auth/Login/forget_password.dart';
import 'package:Qaeat_Provider/Auth/Login/salon_sign_up.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/components/CustomButton.dart';
import 'package:Qaeat_Provider/components/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalonicLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SalonicLogin_State();
  }
}

class SalonicLogin_State extends State<SalonicLogin> {
  final _formSiginKey = GlobalKey<FormState>();
  String _username;
  String _password;
  bool _passwordVisible;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);

  @override
  void initState() {
    _passwordVisible = false;
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return ' الرقم السرى غير صحيح';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'تسجيل الدخول',
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
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Padding(padding: EdgeInsets.all(10),
              child:   Text("البريد الإلكتروني"),
            ),
            CustomTextField(
              onChanged: (String val) {
                setState(() {
                  _username = val;
                });
                print(_username);
              },
              inputType: TextInputType.emailAddress,
              label: "البريد الإلكتروني",
            ),
            Padding(padding: EdgeInsets.all(10),
              child:   Text("كلمة المرور"),
            ),
            CustomTextField(
              onChanged: (String val) {
                setState(() {
                  _password = val;
                });
                print(_password);
              },
              label: "كلمة المرور",
              secureText: true,
            ),

            Padding(padding: EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                runservice();
              },
              child: CustomButton(
                raduis: 10,
                text: "دخول",
              ),
            ),),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgetPassword()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " نسيت كلمة المرور ؟",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SalonSignUp()));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "ليس لديك حساب ؟ سجل الان ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.end,
                  ),
                ),
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
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                        child: Center(
                      child: Text(
                        'أهلا بك !',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 20),
                      ),
                    )),
                    Expanded(
                      child: Container(),
                    ),
                    // Expanded(
                    //   child: IconButton(
                    //     alignment: Alignment.centerLeft,
                    //     icon: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 25,
                    //       color: Colors.white,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
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
      NetworkUtil _util = NetworkUtil();
      showLoadingDialog(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "identify": _username,
        "password": _password,
        "deviceToken": preferences.getString("msgToken")
      });

      print("TOKKEEN AHO YA SERAAG + ${preferences.getString("msgToken")}");
      Response response = await _util.post("salon/login", body: formData);
      if (response.data["status"] == false) {
        Navigator.pop(context);
        errorDialog(
            context: context,
            text: response.data["errNum"] == ""
                ? "خطا في البيانات  .. الرجاء التأكد و اعادة المحاولة"
                : response.data["errNum"]);
      } else {
        Navigator.pop(context);

        preferences.setBool("logged", true);
        preferences.setString(
            "token", "${response.data["salon"]["access_token"]}");
        preferences.setInt("id",response.data["salon"]["id"]);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
                (Route<dynamic> route) => false);      }
    }
}
