import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:Qaeat_Provider/components/CustomButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:Qaeat_Provider/Auth/Login/forget_password.dart';
import 'package:Qaeat_Provider/Auth/Login/reset_password.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';

class CheckCode extends StatefulWidget {
  final String email;

  const CheckCode({Key key, this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckCodeState();
  }
}

class CheckCodeState extends State<CheckCode> {
  TextEditingController code;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  bool valid_code = false;
String check_code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            'كود التفعيل',
            style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> ForgetPassword()));
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Padding(padding: EdgeInsets.all(10),
            child:   Text("ادخل رمز التفعيل الذى تم ارساله اليك",textAlign: TextAlign.end,),
          ),
          Container(
              width: double.infinity,
              height: 100,
              child: Center(
                child: PinCodeTextField(
                  pinBoxWidth: 60,
                  pinBoxHeight: 60,
                  pinBoxColor: Colors.grey[200],
                  onDone: (String value) {
                    print("SSSSSSSSSSSS" + value);
                  setState(() {
                    check_code = value;
                  });
                  },

                  defaultBorderColor: Theme.of(context).primaryColor,
                  pinBoxRadius: 10,
                  highlightPinBoxColor: Colors.grey[50],
                  hasTextBorderColor: Theme.of(context).primaryColor,
                  controller: code,
                  pinTextStyle: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.phone,
                ),
              )),

          Padding(padding: EdgeInsets.all(20),
              child:  CustomButton(
                onButtonPress: () {
                  runservice(check_code);
                },
                raduis: 10,
                text: "التالي",
              )),
        ],
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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'ارسال كلمه السر',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 20),
                      ),
                    )),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      "يرجي ادخال الرمز المرسل علي بيردك الإلكترونى ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),                Expanded(
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
                              builder: (context) => ForgetPassword()));
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

  void runservice(String val) async {
    NetworkUtil _util = NetworkUtil();
    showLoadingDialog(context);
    print(widget.email);
    FormData formData = FormData.fromMap({
      "email": widget.email,
      "otp": val,
    });
    Response response = await _util.post("salon/checkOtp", body: formData);
    if (response.data["status"] == false) {
      Navigator.pop(context);
      errorDialog(context: context, text: "الكود  الذي ادخلته غير صحيح");
    } else {
      Navigator.pop(context);
      errorDialog(
          context: context,
          text: "تم ارسال الكود بنحاح",
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPassword(email: widget.email)));
          });
    }
  }
}
