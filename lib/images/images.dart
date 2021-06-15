import 'dart:convert';
import 'dart:io';

import 'package:Qaeat_Provider/Helper/color.dart';
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

  final picker = ImagePicker();

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
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedFile == null ? null : images.add(File(pickedFile.path));
    });
  }

  // Future addSalonImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     salonImage = File(pickedFile.path);
  //   });
  // }

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
    streemListner(
      context,
    );
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
          text: "تم تعديل صور المركز بنجاح",
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
      "hall_id": preferences.getInt("id"),
      "picture": await MultipartFile.fromFile(logo.path)
    });

    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("admin/salons/update", body: formData);
    print(response.statusCode);
    if (response.data["status"] != false) {
      print("Done");
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
            child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "شعار الهوية",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: InkWell(
                  onTap: () => addNewLogo(),
                  child: isLoading == true
                      ? Center(
                          child: SpinKitThreeBounce(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: logo == null
                                      ? BoxFit.cover
                                      : BoxFit.cover,
                                  image: logo == null
                                      ? NetworkImage("${ress.salon.logo}")
                                      : FileImage(logo)),
                              border: Border.all(color: Colors.grey[500]),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                ),
              ),
              logo == null
                  ? SizedBox()
                  : CustomButton(
                      onButtonPress: () {
                        addLogoImage();
                      },
                      text: "حفظ",
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "صور المركز",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              isLoading == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 150),
                      child: SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 7.3,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: getImage,
                            child: Container(
                              width: 100,
                              height: MediaQuery.of(context).size.height / 7.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                          images.isEmpty
                              ? ListView.builder(
                                  itemCount: ress.salon.gallery.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: InkWell(
                                        onTap: () {
                                          deleteImage(
                                              ress.salon.gallery[index].id,
                                              index);
                                        },
                                        child: Container(
                                          width: 100,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7.5,
                                          child: Center(
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(ress.salon
                                                      .gallery[index].photo),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black45,
                                                      BlendMode.darken))),
                                        ),
                                      ),
                                    );
                                  })
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  height:
                                      MediaQuery.of(context).size.height / 7.5,
                                  child: drowGallaryBox()),
                        ],
                      ),
                    ),
              images.isEmpty
                  ? SizedBox()
                  : CustomButton(
                      onButtonPress: () {
                        addSalonImages();
                      },
                      text: "حفظ",
                    )

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: InkWell(
              //     onTap: () => addSalonImage(),
              //     child: Container(
              //       height: MediaQuery.of(context).size.height / 3.5,
              //       decoration: BoxDecoration(
              //           image: DecorationImage(
              //               fit: salonImage == null
              //                   ? BoxFit.contain
              //                   : BoxFit.cover,
              //               image: salonImage == null
              //                   ? AssetImage("assets/images/logo.png")
              //                   : FileImage(salonImage)),
              //           border: Border.all(color: Colors.grey[500]),
              //           borderRadius: BorderRadius.circular(5)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
