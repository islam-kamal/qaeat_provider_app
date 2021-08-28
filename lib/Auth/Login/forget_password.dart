import 'package:Qaeat_Provider/Auth/Login/salonic_login.dart';
import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/Auth/Login/check_code.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/components/CustomButton.dart';
import 'package:Qaeat_Provider/components/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgetPassword_State();
  }
}

class ForgetPassword_State extends State<ForgetPassword> {
  final _formSiginKey = GlobalKey<FormState>();
  String _username;
  TextEditingController _password;
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
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'نسيت كلمة المرور',
              style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
            ),
          ),
          actions: [
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context)=> SalonicLogin()));
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
          child:Form(
          key: _formSiginKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "هل نسيت كلمة المرور الخاصة بك ؟؟",
                  style: TextStyle(
                      fontSize: 17,
                      wordSpacing: 5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    "اكتب بريدك الالكتروني الخاص بك ",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child:   Text("البريد الإلكتروني"),
              ),
              CustomTextField(
                validate: (String val) {
                  if (val == null) {
                    return "يردجي ادخال بريد الكتروني";
                  }
                },
                onChanged: (String val) {
                  setState(() {
                    _username = val;
                  });
                },
                label: "Example@gmail.com",
                inputType: TextInputType.emailAddress,
              ),
          Padding(padding: EdgeInsets.all(20),
            child:  CustomButton(
                onButtonPress: () {
                  runservice();
                },
                raduis: 10,
                text: "ارسال",
            )),
            ],
          ),
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
                      child: IconButton(
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
    NetworkUtil _util = NetworkUtil();
    showLoadingDialog(context);
    if (!_formSiginKey.currentState.validate()) {
      return;
    } else {
      _formSiginKey.currentState.save();
      print(_username);
      FormData formData = FormData.fromMap({
        "email": _username,
      });
      Response response =
          await _util.post("salon/sendNotification", body: formData);
      if (response.data["status"] == false) {
        Navigator.pop(context);

        errorDialog(context: context, text: "البريد الذي ادخلته غير صحيح");
      } else {
        Navigator.pop(context);
        errorDialog(
            context: context,
            text: "تم ارسال الكود بنحاح",
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckCode(
                            email: _username,
                          )));
            });
      }
    }
  }
}
