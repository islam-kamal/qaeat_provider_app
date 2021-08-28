import 'dart:convert';
import 'dart:io';

import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomBottomSheet.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomButton.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/Service/allSalonServices.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/components/custom_text_field.dart';
import 'package:Qaeat_Provider/models/categories_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String name, details, price, discount, estimated_time, category_name;
  File picture;
  int category_id;
  int issCash = 0;
  bool house = true;
  bool booking_before = true;
  CategoriesResponse ress = CategoriesResponse();
  bool isLoading = true;
  final picker = ImagePicker();
  File logo;

  TextEditingController nameController =TextEditingController();
  TextEditingController detailsController =TextEditingController();
  TextEditingController nationalityController =TextEditingController();
  TextEditingController priceController =TextEditingController();
  TextEditingController timeController =TextEditingController();
  TextEditingController bounsController =TextEditingController();
  // TextEditingController nationalityController =TextEditingController();

  Future addNewLogo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      logo = File(pickedFile.path);
    });
  }

 /* void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/categories/get-all-categories", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = CategoriesResponse.fromJson(json.decode(response.toString()));
        isLoading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }*/

  void addService() async {
    if (name == null) {
      errorDialog(
          context: context,
          text: "الرجاء ادخال الاسم",
          function: () {
            Navigator.pop(context);
          });
    } else if (details == null || details.length < 8) {
      errorDialog(
          context: context,
          text: "الرجاء ادخال وصف كامل للخدمة ",
          function: () {
            Navigator.pop(context);
          });
    }
    /*else if (booking_before == null) {
      errorDialog(
          context: context,
          text: "الرجاء اختيا طريقة الحجز ",
          function: () {
            Navigator.pop(context);
          });
    } else if (house == null) {
      errorDialog(
          context: context,
          text: "الرجاء مكان الخدة",
          function: () {
            Navigator.pop(context);
          });
    } */
    else if (price == null) {
      errorDialog(
          context: context,
          text: "الرجاء سعر الخدمة",
          function: () {
            Navigator.pop(context);
          });
    }
    else if (discount == null) {
      errorDialog(
          context: context,
          text: "الرجاء نسبة الخصم",
          function: () {
            Navigator.pop(context);
          });
    }
    /*else if (estimated_time == null) {
      errorDialog(
          context: context,
          text: "الرجاء ادخال مدة الخدمة بالدقائق",
          function: () {
            Navigator.pop(context);
          });
    } else if (category_id == null) {
      errorDialog(
          context: context,
          text: "الرجاء احتيار القسم ",
          function: () {
            Navigator.pop(context);
          });
    }*/
    else if (logo == null) {
      errorDialog(
          context: context,
          text: "الرجاء ادراج صورة الخدمة",
          function: () {
            Navigator.pop(context);
          });
    } else {
      showLoadingDialog(context);
      print(issCash);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      FormData formData = FormData.fromMap({
        "token": preferences.getString("token"),
        "name": name,
        "hall_id": preferences.getInt("id"),
        "details": details,
        //"booking_before": booking_before == true ? 1 : 0,
        //"home_service": house == true ? 1 : 0,
        "price": price,
        "discount": discount,
        "payment": issCash == 1 ? 1 : issCash == 0 ? 0 : 2,
      //  "estimated_time": estimated_time,
       // "category_id": category_id,
        "picture": logo == null ? null : await MultipartFile.fromFile(logo.path)
      });

      NetworkUtil _util = NetworkUtil();
      Response response =
          await _util.post("admin/services/store", body: formData);
      print(response.statusCode);
      if (response.data["status"] == true) {
        print("Done");
        Navigator.pop(context);
        onDoneDialog(
            context: context,
            text: "تم اضافة الخدمة بنجاح",
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllServices()));
            });
      } else {
        print("ERROR");
        print(response.data.toString());
      }
    }
  }

  @override
  void initState() {
   // getData();
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
          "أضافة الخدمة",
          style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
        ),
      ),
      actions: [
        InkWell(
          onTap: (){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
                    (Route<dynamic> route) => false);
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
          child:ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "صورة الخدمة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
              child: InkWell(
                onTap: () => addNewLogo(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: logo == null ? BoxFit.contain : BoxFit.cover,
                          image: logo == null
                              ? AssetImage("assets/images/index.png")
                              : FileImage(logo)),
                      border: Border.all(color: Colors.grey[500]),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "اسم الخدمة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right:8.0),
                child:CustomTextField(
              controller: nameController,
              onChanged: (String val) {
                setState(() {
                  name = val;
                });
              },
              label: "اسم الخدمة",
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "تفاصيل الخدمة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: CustomTextField(
              controller: detailsController,
              onChanged: (String val) {
                setState(() {
                  details = val;
                });
              },
              lines: 5,
              label: "تفاصيل الخدمة",
            )),
         /*   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "اختيار القسم",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => CustomSheet(
                    context: context,
                    widget: ListView.builder(
                        itemCount: ress.categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                category_id = ress.categories[index].id;
                                category_name = ress.categories[index].name;
                              });
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${ress.categories[index].name}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                ),
                                Divider()
                              ],
                            ),
                          );
                        })),
                child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category_name ?? "اختيار القسم",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[500]),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[500])),
                ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "سعر الخدمة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: CustomTextField(
              controller: priceController,
              onChanged: (String val) {
                setState(() {
                  price = val;
                });
              },
              inputType: TextInputType.phone,
              label: "سعر الخدمة",
            )),
         /*   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "الوقت المحدد للخدمة بالدقائق",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextField(
              controller: timeController,
              onChanged: (String val) {
                setState(() {
                  estimated_time = val;
                });
              },

              inputType: TextInputType.phone,
              label: "  الوقت المحدد للخدمة بالدقائق",
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "خصم على الخدمة ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right:8.0),
                child:CustomTextField(
              controller: bounsController,
              onChanged: (String val) {
                setState(() {
                  discount = val;
                });
              },

              inputType: TextInputType.phone,
              label: "اكتب خصم الخدمه ان وجد ",
            )),
           /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "خدمات المنزل",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      house = !house;
                    });
                  },
                  child: Row(
                    children: [
                      house == true
                          ? Icon(Icons.radio_button_checked)
                          : Icon(Icons.radio_button_unchecked),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "متاح",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      house = !house;
                    });
                  },
                  child: Row(
                    children: [
                      house == false
                          ? Icon(Icons.radio_button_checked)
                          : Icon(Icons.radio_button_unchecked),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "غير متاح",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "طرق الدفع",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      issCash = 0;
                      print("issCash : ${issCash}");
                    });
                  },
                  child: Row(
                    children: [
                      issCash == 0
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "كاش",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      issCash = 1;
                      print("issCash : ${issCash}");

                    });
                  },
                  child: Row(
                    children: [
                      issCash == 1
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "اونلاين",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      issCash = 2;
                      print("issCash : ${issCash}");

                    });
                  },
                  child: Row(
                    children: [
                      issCash == 2
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "كلاهما",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  addService();
                },
                child: CustomButton(
                  text: "اضافة ",
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
