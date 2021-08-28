import 'dart:convert';

import 'package:Qaeat_Provider/Auth/Login/salonic_login.dart';
import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:Qaeat_Provider/models/category_model.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class SalonSignUp extends StatefulWidget {
  @override
  _SalonSignUpState createState() => _SalonSignUpState();
}

class _SalonSignUpState extends State<SalonSignUp> {
  String name,
      username,
      password,
      email,
      city_name,
      provider_address,
      hall_individuals,
      category_name;
  int city_id, category_id;
  double provider_lat, provider_lng;
  GoogleMapController mapController;
  Position _currentPosition;
  final LatLng _center = const LatLng(24.7241503, 46.262039);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  CitiesResponse ress_cities = CitiesResponse();
  CategoryModel ress_categories = CategoryModel();

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
        ress_cities = CitiesResponse.fromJson(json.decode(response.toString()));
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  void getCategoriesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
    });
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post(
      "admin/categories/index",
    );
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress_categories =
            CategoryModel.fromJson(json.decode(response.toString()));
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    getData();
    getCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            'أنشاء حساب جديد',
            style: TextStyle(
                fontFamily: 'Cairo', color: Colors.white, fontSize: 16),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SalonicLogin()));
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
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("اسم الحساب"),
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  username = val;
                });
                print(username);
              },
              hint: " اسم الحساب",
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("اسم المستخدم"),
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  name = val;
                });
                print(name);
              },
              hint: "اسم المستخدم",
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("البريد الإلكتروني"),
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
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("كلمة المرور"),
            ),
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
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("نوع الخدمة"),
            ),
            category_type(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("المدينة"),
            ),
            city_conyainer(),

            /*        Padding(padding: EdgeInsets.all(10),
              child:   Text("العنوان"),
            ),
            CustomTextField(
              value: (String val) {
                setState(() {
                  provider_address = val;
                });
                print(provider_address);
              },
              hint: "العنوان",
            ),*/

//-----------------------------------------------
            detect_guest_location(
                name: 'islam', lang: _center.longitude, lat: _center.latitude),

            //-----------------------------------

            category_id == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("عدد الافراد"),
                      ),
                      CustomTextField(
                        value: (String val) {
                          setState(() {
                            hall_individuals = val;
                          });
                          print('hall_individuals : ${hall_individuals}');
                        },
                        inputType: TextInputType.number,
                        hint: "عدد الافراد",
                      ),
                    ],
                  )
                : Container(),

            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            InkWell(
              onTap: () {
                runservice();
              },
              child: CustomButton(
                raduis: 10,
                text: "تسجيل ",
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
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
    print(provider_address);
    print(city_id);
    print("category_id : ${category_id}");
    print(password);
    if (username == null || username.length < 3) {
      errorDialog(context: context, text: "يرجي ادخال الاسم بشكل صحيح");
    } else if (name == null) {
      errorDialog(
          context: context, text: "يرجي ادخال اسم مقدم الخدمة بشكل صحيح");
    } else if (email == null) {
      errorDialog(
          context: context, text: "يرجي ادخال البريد الالكتروني بشكل صحيح");
    } else if (provider_address == null) {
      errorDialog(context: context, text: "يرجي ادخال العنوان بشكل صحيح");
    } else if (city_id == null) {
      errorDialog(context: context, text: "يرجي اختيار المدينة");
    } else if (category_id == null) {
      errorDialog(context: context, text: "يرجي اختيار نوع الخدمة");
    } else if (password == null || password.length < 8) {
      errorDialog(
          context: context, text: "يرجي ادخال كلمة مرور لا تقل عن 8 احرف");
    } else {
      NetworkUtil _util = NetworkUtil();
      showLoadingDialog(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print("lat : ${provider_lat}");
      print("lng : ${provider_lng}");

      FormData formData = FormData.fromMap({
        "username": username,
        "name": name,
        "address": provider_address  ,
        "city_id": city_id,
        "email": email,
        "password": password,
        "reCAPTCHA": "on",
        "category_id": category_id,
        "hall_max_number": hall_individuals,
        "deviceToken": preferences.getString("msgToken"),
        "Latitude":  provider_lat ?? _currentPosition.latitude,
        "Longitude": provider_lng ?? _currentPosition.longitude
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
                itemCount: ress_cities.cities.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        city_id = ress_cities.cities[index].id;
                        city_name = ress_cities.cities[index].name;
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Text(ress_cities.cities[index].name),
                        Divider()
                      ],
                    ),
                  );
                }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    city_name ?? "المدينة",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                  )
                ],
              )),
          decoration: BoxDecoration(
              border: Border.all(
                  color: city_id == null
                      ? Colors.grey
                      : Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget category_type() {
    return InkWell(
      onTap: () {
        CustomSheet(
            context: context,
            height: MediaQuery.of(context).size.width * 1.5,
            widget: ListView.builder(
                itemCount: ress_categories.categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        category_id = ress_categories.categories[index].id;
                        category_name = ress_categories.categories[index].name;
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Text(ress_categories.categories[index].name),
                        Divider()
                      ],
                    ),
                  );
                }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category_name ?? "نوع الخدمة",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                  )
                ],
              )),
          decoration: BoxDecoration(
              border: Border.all(
                  color: city_id == null
                      ? Colors.grey
                      : Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget detect_guest_location({String name, double lat, double lang}) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.only(right: width * .03, left: width * .03),
            child: Text("اختار العنوان من الخريطة"),
          ),
        ]),
        Padding(
          padding: EdgeInsets.all(15),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.5,
              color: Colors.white,
              child: Stack(
                children: [
                  GoogleMap(
                   // myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    onMapCreated: _onMapCreated,
                    markers: Set<Marker>.of(markers.values),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, lang),
                      zoom: 5.0,
                    ),
                    onTap: (latLng) async {
                      provider_lat = latLng.latitude;
                      provider_lng = latLng.longitude;
                      final coordinates =
                          new Coordinates(latLng.latitude, latLng.longitude);
                      var addresses = await Geocoder.local
                          .findAddressesFromCoordinates(coordinates);
                      var address = addresses.first;
                      provider_address = address.addressLine;
                      _add(
                          lat: latLng.latitude,
                          lng: latLng.longitude,
                          address: address.addressLine);
                    },
                  ),
                  Positioned(
                    top: -40,
                    child: SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.0, top: width * 0.3),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.my_location,
                                  color: QaeatColor.black_color,
                                ),
                              ),
                              onTap: () {
                                mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        _currentPosition.latitude,
                                        _currentPosition.longitude,
                                      ),
                                      zoom: 18.0,
                                    ),
                                  ),
                                );
                                _add(lat: _currentPosition.latitude , lng: _currentPosition.longitude , address: provider_address );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),)
                ],
              )),
        )
      ],
    );
  }

  void _add({double lat, double lng, String address}) {
    final MarkerId markerId = MarkerId('qaeat');
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: MarkerId(address),
      infoWindow: InfoWindow(
        title: address,
      ),
      position: LatLng(
        lat,
        lng,
      ),
      onTap: () {},
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    Geolocator geolocator = Geolocator();
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() async{
        print("position : ${position.longitude}");
        _currentPosition = position;
        final coordinates =
        new Coordinates(position.latitude, position.longitude);
        var addresses = await Geocoder.local
            .findAddressesFromCoordinates(coordinates);
        var address = addresses.first;
        provider_address = address.addressLine;
        print('CURRENT POS: $_currentPosition');
/*        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );*/
      });
    }).catchError((e) {
      print(e);
    });
  }
}
