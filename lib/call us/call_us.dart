import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Qaeat_Provider/Utils/NetWorkHelper.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:Qaeat_Provider/models/social_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CallUs extends StatefulWidget {
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  SocialModel model = SocialModel();

  bool isLoading = true;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "token": preferences.getString("token"),
    });

    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.post("admin/salons/get-app-social", body: formData);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        model = SocialModel.fromJson(json.decode(response.toString()));
        isLoading = false;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تواصل معنا',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),
      ),
      body: isLoading == true
          ? Center(
              child: SpinKitThreeBounce(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                  itemCount: model.socialMedia.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        InkWell(
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 20, top: 15, bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Card(
                                  color: Color(0xFFF6F6F6),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      '${model.socialMedia[index].logo}',
                                      width: MediaQuery.of(context).size.width /
                                          14,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              14,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '${model.socialMedia[index].name}',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            switch (index) {
                              case 0:
                                setState(() {
                                  _launchURL(
                                      'mailto:${model.socialMedia[index].link}');
                                });
                                break;
                              case 1:
                                _launchURL(
                                    'whatsapp://send?phone=+966${model.socialMedia[index].link}');
                                break;
                              case 2:
                                _launchURL(model.socialMedia[index].link);
                                break;
                              case 3:
                                _launchURL(
                                    'tel:${model.socialMedia[index].link}');
                                break;
                            }
                          },
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                        ),
                        /*
                            Padding(
                              padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                              child:Row(
                                children: <Widget>[
                                  Card(
                                    color: Color(0xFFF6F6F6),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:  Center(
                                        child: Image(
                                          width: MediaQuery.of(context).size.width / 14,
                                          height: MediaQuery.of(context).size.width / 14,
                                          image: AssetImage('images/more/phone.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'تواصل معنا عبر الموبايل',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ) ,
                            ),
                            Divider(color: Colors.grey.shade300,),
                            Padding(
                              padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                              child:Row(
                                children: <Widget>[
                                  Card(
                                    color: Color(0xFFF6F6F6),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:  Center(
                                        child: Image(
                                          width: MediaQuery.of(context).size.width / 14,
                                          height: MediaQuery.of(context).size.width / 14,
                                          image: AssetImage('images/more/whatsapp.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'تواصل معنا عبر الواتس اب',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ) ,
                            ),
                            Divider(color: Colors.grey.shade300,),
                            Padding(
                              padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                              child:Row(
                                children: <Widget>[
                                  Card(
                                    color: Color(0xFFF6F6F6),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:  Center(
                                        child: Image(
                                          width: MediaQuery.of(context).size.width / 14,
                                          height: MediaQuery.of(context).size.width / 14,
                                          image: AssetImage('images/more/twitter.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'تواصل معنا عبر تويتر',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ) ,
                            ),
                            Divider(color: Colors.grey.shade300,),

                             */
                      ],
                    );
                  })
/*
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                child:Row(
                  children: <Widget>[
                    Card(
                      color: Color(0xFFF6F6F6),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:  Center(
                          child: Image(
                            width: MediaQuery.of(context).size.width / 14,
                            height: MediaQuery.of(context).size.width / 14,
                            image: AssetImage('images/more/facebook.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'تواصل معنا عبر الفيسبوك',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ) ,
              ),
              Divider(color: Colors.grey.shade300,),
              Padding(
                padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                child:Row(
                  children: <Widget>[
                    Card(
                      color: Color(0xFFF6F6F6),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:  Center(
                          child: Image(
                            width: MediaQuery.of(context).size.width / 14,
                            height: MediaQuery.of(context).size.width / 14,
                            image: AssetImage('images/more/phone.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'تواصل معنا عبر الموبايل',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ) ,
              ),
              Divider(color: Colors.grey.shade300,),
              Padding(
                padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                child:Row(
                  children: <Widget>[
                    Card(
                      color: Color(0xFFF6F6F6),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:  Center(
                          child: Image(
                            width: MediaQuery.of(context).size.width / 14,
                            height: MediaQuery.of(context).size.width / 14,
                            image: AssetImage('images/more/whatsapp.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'تواصل معنا عبر الواتس اب',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ) ,
              ),
              Divider(color: Colors.grey.shade300,),
              Padding(
                padding:EdgeInsets.only(right: 20,top: 15,bottom: 15),
                child:Row(
                  children: <Widget>[
                    Card(
                      color: Color(0xFFF6F6F6),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:  Center(
                          child: Image(
                            width: MediaQuery.of(context).size.width / 14,
                            height: MediaQuery.of(context).size.width / 14,
                            image: AssetImage('images/more/twitter.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'تواصل معنا عبر تويتر',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ) ,
              ),
              Divider(color: Colors.grey.shade300,),

            ],

          ),
        ),


 */
              ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
