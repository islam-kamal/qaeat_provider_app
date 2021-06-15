//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class Carousel extends StatefulWidget {
//  final List<Uploads> img;
//
//  const Carousel({Key key, this.img}) : super(key: key);
//
//  @override
//  _CarouselState createState() => _CarouselState();
//}
//
//class _CarouselState extends State<Carousel> {
//  List empty = [
//    "https://www.freeiconspng.com/uploads/warning-error-icon-png-33.png"
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return CarouselSlider(
//      options: CarouselOptions(
//        height: MediaQuery.of(context).size.height * 0.3,
//        viewportFraction: 0.97,
//        aspectRatio: 2.0,
//        autoPlay: true,
//        initialPage: 1,
//        reverse: true,
//        enlargeCenterPage: true,
//        autoPlayInterval: Duration(seconds: 3),
//        enableInfiniteScroll: true,
//        autoPlayAnimationDuration: Duration(milliseconds: 400),
//      ),
//      items: widget.img.isEmpty? ["https://www.freeiconspng.com/uploads/warning-error-icon-png-33.png"].map(
//            (url) {
//          return Container(
//            child: ClipRRect(
////              borderRadius: BorderRadius.all(Radius.circular(25)),
//              child: InkWell(
//                onTap: () => showImageDialog(url),
//                child: Column(
//                  children: <Widget>[
//                    Image.network(
//                      url,
//                      fit: BoxFit.contain,
//                      width: MediaQuery.of(context).size.width/2.5,
//                    ),
//                    Text("خطأ في صيغة الصورة"),
//                  ],
//                ),
//              ),
//            ),
//          );
//        },
//      ).toList():widget.img.map(
//        (url) {
//          return Container(
//                  child: ClipRRect(
////                    borderRadius: BorderRadius.all(Radius.circular(25)),
//                    child: InkWell(
//                      onTap: () => showImageDialog(url.image),
//                      child: Image.network(
//                        url.image,
//                        fit: BoxFit.fitWidth,
//                        width: MediaQuery.of(context).size.width,
//                      ),
//                    ),
//                  ),
//                );
//        },
//      ).toList(),
//    );
//  }
//
//  void showImageDialog(String image) {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return CupertinoDialog(
//            child: Image.network(image),
//          );
//        });
//  }
//}
