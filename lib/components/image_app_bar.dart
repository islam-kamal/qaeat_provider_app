import 'package:flutter/material.dart';

class ImageAppBar extends StatefulWidget {
  @override
  _ImageAppBarState createState() => _ImageAppBarState();
}

class _ImageAppBarState extends State<ImageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Center(
          child: Image.asset(
        "assets/images/logo.png",
        width: MediaQuery.of(context).size.width / 2,
        height: 60,
      )),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
    );
  }
}
