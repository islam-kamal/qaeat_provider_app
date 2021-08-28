import 'package:Qaeat_Provider/Auth/Login/check_code.dart';
import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/Auth/Login/salonic_login.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/components/CustomButton.dart';
import 'package:Qaeat_Provider/components/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({Key key, this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  final _formSiginKey = GlobalKey<FormState>();
  String _confirm_password;
  String _password;
  bool _passwordVisible;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  bool valid_code = false;

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'هذا الرقم السرى غير صحيح';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            'أعادة تعين كلمة المرور',
            style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> CheckCode()));
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
    child: Form(
        key: _formSiginKey,
        child: ListView(
          children: <Widget>[
        //   page_header(),
            Padding(padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
              child:   Text("قم بكتابة كلمة المرور الجديدة",),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:   Text("كلمة المرور",),
            ),
            CustomTextField(
              validate: (String val) {
                if (val.trim() == "" || val.length < 6) {
                  return "الرجاء ادخال كلمة مرور لا تقل عن 6 احرف";
                }
              },
              onChanged: (String val) {
                setState(() {
                  _password = val;
                });
              },
              label: "************",
              secureText: true,
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:   Text("اعادة كتابة كلمة المرور",),
            ),
            CustomTextField(
              validate: (String val) {
                if (val != _password) {
                  return "كلمتان المرور غير متطابقتان";
                }
              },
              onChanged: (String val) {
                setState(() {
                  _confirm_password = val;
                });
              },
              label: "************",
              secureText: true,
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
           Padding(padding: EdgeInsets.only(top: 30),
               child:  InkWell(
             onTap: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => SalonicLogin()));
             },
             child: CustomButton(
               raduis: 10,
               text: "تغيير",
             ),
           ),)
          ],
        ),
    )),
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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'اعاده تعيين كلمه السر',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Cairo', fontSize: 20),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalonicLogin()));
                    },
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
      print(_password);
      print(_confirm_password);

      FormData formData = FormData.fromMap({
        "email": widget.email,
        "password ": _password,
        "password_confirmation": _confirm_password
      });
      Response response =
          await _util.post("salon/resetPassword", body: formData);
      if (response.data["status"] == false) {
        errorDialog(context: context, text: response.data["errNum"]);
      } else {
        Navigator.pop(context);
        errorDialog(
            context: context,
            text: "تمتغير كلمة المرور بنحاح",
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SalonicLogin()));
            });
      }
    }
  }
}
