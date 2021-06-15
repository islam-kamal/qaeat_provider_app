import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomBottomSheet.dart';
import 'package:Qaeat_Provider/CustomWidgets/CustomButton.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/Service/allSalonServices.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/components/custom_text_field.dart';
import 'package:Qaeat_Provider/models/categories_response.dart';
import 'package:Qaeat_Provider/models/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditService extends StatefulWidget {
  final SalonServices services;

  const EditService({Key key, this.services}) : super(key: key);

  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  String name, details, price, bonus, estimated_time, category_name;
  File picture;
  int category_id;
  int issCash;

  bool house = true;
  bool booking_before = true;
  CategoriesResponse ress = CategoriesResponse();
  bool isLoading = true;
  GlobalKey<FormState> key = GlobalKey();

  final picker = ImagePicker();
  File logo;

  Future addNewLogo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      logo = File(pickedFile.path);
    });
  }

  void getData() async {
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
  }

  void addService() async {
    if (!key.currentState.validate()) {
      return;
    }
    showLoadingDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "id": widget.services.id,
      "name": name,
      "salon_id": preferences.getInt("id"),
      "details": details,
      "booking_before": booking_before == true ? 1 : 0,
      "home_service": house == true ? 1 : 0,
      "price": price,
      "bonus": bonus,
      "payment": issCash == 1 ? 1 : issCash ==0? 0 :2,
      "estimated_time": estimated_time,
      "category_id": category_id,
      "picture": logo == null ? null : await MultipartFile.fromFile(logo.path)
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/services/update", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllServices()));
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    issCash = widget.services.payment == 1 ? 1 : 0;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
        appBar: AppBar(
          title: Text("تعديل الخدمة ",style: TextStyle(color: Colors.white),),
          leading:  InkWell(
            onTap: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllServices(),
                  ),
                      (Route<dynamic> route) => false);
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),

        ),
        body: Form(
          key: key,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "صورة الخدمة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                child: InkWell(
                  onTap: () => addNewLogo(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                        image: DecorationImage(

                            fit: logo == null ? BoxFit.cover : BoxFit.cover,
                            image: logo == null
                                ? NetworkImage(widget.services.icon)
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
              CustomTextField(
                onChanged: (String val) {
                  setState(() {
                    name = val;
                  });
                },
                validate: (String val) {
                  if (val == null) {
                    return "الرجاء اكمال البيانات";
                  }
                },
                label: widget.services.name,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "تفاصيل الخدمة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                onChanged: (String val) {
                  setState(() {
                    details = val;
                  });
                },
                validate: (String val) {
                  if (val == null) {
                    return "الرجاء اكمال البيانات";
                  }
                },
                lines: 5,
                label: widget.services.details,
              ),
  /*            Padding(
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
                        category_name ?? "${widget.services.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
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
              CustomTextField(
                onChanged: (String val) {
                  setState(() {
                    price = val;
                  });
                },
                validate: (String val) {
                  if (val == null) {
                    return "الرجاء اكمال البيانات";
                  }
                },
                inputType: TextInputType.phone,
                label: "${widget.services.price}",
              ),
        /*      Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "الوقت المحدد للخدمة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                onChanged: (String val) {
                  setState(() {
                    estimated_time = val;
                  });
                },
                validate: (String val) {
                  if (val == null) {
                    return "الرجاء اكمال البيانات";
                  }
                },
                inputType: TextInputType.phone,
                label: "${widget.services.estimatedTime}",
              ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "خصم علي الخدمة ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                onChanged: (String val) {
                  setState(() {
                    bonus = val;
                  });
                },
                validate: (String val) {
                  if (val == null) {
                    return "الرجاء اكمال البيانات";
                  }
                },
                inputType: TextInputType.phone,
                label: "${widget.services.discount}",
              ),
         /*     Padding(
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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        issCash = 1;
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
                        issCash = 0;
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
                            "اونلاين",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ), SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        issCash = 2;
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: InkWell(
                    onTap: () {
                      addService();
                    },
                    child: CustomButton(
                      text: "حفظ ",
                    )),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
