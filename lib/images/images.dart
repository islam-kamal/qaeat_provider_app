import 'dart:convert';
import 'dart:io';

import 'package:Qaeat_Provider/CustomWidgets/CustomBottomSheet.dart';
import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:Qaeat_Provider/Helper/static_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Qaeat_Provider/CustomWidgets/ErrorDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/LoadingDialog.dart';
import 'package:Qaeat_Provider/CustomWidgets/on_done_dialog.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/Utils/show_toast.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/components/CustomButton.dart';
import 'package:Qaeat_Provider/components/custom_app_bar.dart';
import 'package:Qaeat_Provider/models/salon_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalonImages extends StatefulWidget {
  @override
  _SalonImagesState createState() => _SalonImagesState();
}

class _SalonImagesState extends State<SalonImages> {
  File logo, salonImage;
  List<File> images = [];
  var rating_border = 1; // 1------------> images , 2 ----------> logo
  bool show_logo = true;
  final picker = ImagePicker();
  String app_logo;
  Widget drowGallaryBox() {
    return ListView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 100,
              height: MediaQuery.of(context).size.height / 7.5,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: FileImage(images[index]),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken))),
            ),
          );
        });
  }

  Future addNewLogo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      logo = File(pickedFile.path);
      show_logo = true;
    });
    addLogoImage();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedFile == null ? null : images.add(File(pickedFile.path));
    });
    addSalonImages();
  }

  SalonResponse ress = SalonResponse();
  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/salons/get-salon", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = SalonResponse.fromJson(json.decode(response.toString()));
        isLoading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  NotificationMethos methos = NotificationMethos();

  streemListner(BuildContext contetext) {
    methos.appPushNotifications.notificationSubject.stream.listen((data) {
      print("------------------XXXXXX-------- $data");
      setState(() {
        methos.showToast(data['notification']['title'],
            data['notification']['body'], contetext, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contetext) => MainPage(
                        index: 2,
                      )));
        });
      });
    });
  }

  @override
  void initState() {
    streemListner(context,);
    getData();
    super.initState();
  }

  void addSalonImages() async {
    List<MultipartFile> _photos = [];

    SharedPreferences preferences = await SharedPreferences.getInstance();
    showLoadingDialog(context);
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "hall_id": preferences.getInt("id")
    });

    for (int i = 0; i < images.length; i++) {
      _photos.add(MultipartFile.fromFileSync(images[i].path,
          filename: "${images[i].path}.jpg"));
      formData.files.add(MapEntry("picture[${i}]", _photos[i]));
    }

    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("admin/photos/store", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      print("Done");
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: "تم تعديل صور مقدم الخدمة بنجاح",
          function: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SalonImages()));
          });
    } else {
      print("ERROR");
      print(response.data.toString());
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
    }
  }

  void addLogoImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    showLoadingDialog(context);
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "id": preferences.getInt("id"),
      "picture": await MultipartFile.fromFile(logo.path)
    });

    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("admin/salons/update", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      print("Done");
      StaticMethods.app_logo = response.data["salon"]["logo"];
      print("  StaticMethods.app_logo  : ${  StaticMethods.app_logo }");
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: "تم تغير الشعار بنجاح",
          function: () {
            Navigator.pop(context);
            setState(() {
              isLoading = true;
            });
            getData();
          });
    } else {
      print("ERROR");
      Navigator.pop(context);
      print(response.data.toString());
    }
  }

  void deleteImage(int id, int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    showLoadingDialog(context);
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
      "id": id,
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/photos/destroy", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      print("Done");
      Navigator.pop(context);

      onDoneDialog(
          context: context,
          text: "تم حذف الصورة بنجاح",
          function: () {
            setState(() {
              ress.salon.gallery.removeAt(index);
            });
            Navigator.pop(context);
          });
    } else {
      print("ERROR");
      Navigator.pop(context);
      print(response.data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (Route<dynamic> route) => false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "الصور",
              style: TextStyle(
                  fontFamily: 'Cairo', color: Colors.white, fontSize: 16),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 6,
                              top: 5,
                              bottom: 5),
                          decoration: BoxDecoration(
                            border: rating_border == 1
                                ? Border(
                                    bottom: BorderSide(color: Colors.black))
                                : Border(
                                    bottom:
                                        BorderSide(color:  Colors.grey.shade200)),
                          ),
                          child: Text(
                            'الصور',
                            style: rating_border == 1
                                ? TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)
                                : TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            rating_border = 1;
                          });
                        },
                      ),
                      Spacer(),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 6,
                              top: 5,
                              bottom: 5),
                          decoration: BoxDecoration(
                            border: rating_border == 2
                                ? Border(
                                    bottom: BorderSide(color: Colors.black))
                                : Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200)),
                          ),
                          child: Text(
                            'الشعار',
                            style: rating_border == 2
                                ? TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)
                                : TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            rating_border = 2;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              rating_border == 2  ? Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    addNewLogo();
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border:
                                            Border.all(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Text(
                                    "إضافة صورة جديدة",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )),
                        show_logo  ?   Stack(
                          children: [
                            Card(
                              child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: logo == null
                                            ? NetworkImage(
                                            "${ress.salon.logo}")
                                            : FileImage(logo)),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 130, right: 20, left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              50)),
                                      child:      InkWell(
                                        onTap: () {
                                          setState(() {
                                            show_logo = false;
                                            ress.salon.logo = null;
                                            logo = null;
                                          });
                                        },
                                        child:Container(
                                          child: Center(
                                            child: Icon(Icons.delete,color: QaeatColor.primary_color),
                                          ),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                        ),
                                      ) ),
                                ],
                              ),
                            ),

                          ],
                        ) :
                            Container()
                       /* Stack(
                          children: [
                            Card(
                              child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: logo == null
                                            ? NetworkImage(
                                            "${ress.salon.logo}")
                                            : FileImage(logo)),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 130, right: 20, left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              50)),
                                      child:      InkWell(
                                        onTap: () {
                                          setState(() {
                                            show_logo = false;

                                          });
                                        },
                                        child:Container(
                                          child: Center(
                                            child: Icon(Icons.delete,color: QaeatColor.primary_color),
                                          ),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                        ),
                                      ) ),
                                ],
                              ),
                            ),

                          ],
                        )*/
                      ]))

                  :   Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border:
                                        Border.all(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Text(
                                    "إضافة صورة جديدة",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )),
                        isLoading == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 150),
                                child: SpinKitThreeBounce(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : Container(
                                //width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.8,
                                child:  images.isEmpty
                                    ? ListView.builder(
                                    itemCount:
                                    ress.salon.gallery.length,
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {

                                      return Stack(
                                        children: [
                                          Card(
                                            child: Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                      NetworkImage(ress.salon.gallery[index].photo),),)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 130, right: 20, left: 20),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(),
                                                Card(
                                                    elevation: 10,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                    child:      InkWell(
                                                      onTap: () {
                                                        deleteImage(
                                                            ress.salon.gallery[index].id, index);
                                                      },
                                                      child:Container(
                                                        child: Center(
                                                          child: Icon(Icons.delete,color: QaeatColor.primary_color,),
                                                        ),
                                                        width: 40,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle),
                                                      ),
                                                    ) ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      );
                         /*             return Padding(
                                        padding:
                                        const EdgeInsets.symmetric(vertical: 10,
                                            horizontal: 5),
                                        child: InkWell(
                                          onTap: () {
                                            deleteImage(
                                                ress.salon
                                                    .gallery[index].id,
                                                index);
                                          },
                                          child: Container(
                                            width: 100,
                                            height:
                                            MediaQuery.of(context)
                                                .size
                                                .height /
                                                5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(10),
                                                image: DecorationImage(
                                                    image:
                                                    NetworkImage(ress
                                                        .salon
                                                        .gallery[
                                                    index]
                                                        .photo),
                                                    fit: BoxFit.fill,
                                                    colorFilter:
                                                    ColorFilter.mode(
                                                        Colors
                                                            .black45,
                                                        BlendMode
                                                            .darken))),
                                          ),
                                        ),
                                      );*/
                                    })
                                    : Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        120,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height /
                                        7.5,
                                    child: drowGallaryBox()),
                              ),

                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
