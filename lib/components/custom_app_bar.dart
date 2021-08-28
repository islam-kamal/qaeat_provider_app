import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String titel;
  final Widget icon;

  const CustomAppBar({Key key, this.titel, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(),
          Text(
            "${titel}",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          icon ?? SizedBox(),
        ],
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
    );
  }
}
