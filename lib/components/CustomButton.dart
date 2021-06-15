import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width, higth, opacity, raduis;
  final String text;
  final Function onButtonPress;

  const CustomButton(
      {Key key,
      this.width,
      this.higth,
      this.text,
      this.opacity,
      this.raduis,
      this.onButtonPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: QaeatColor.primary_color,
              borderRadius: BorderRadius.circular(raduis ?? 5)),
          width: width ?? 140,
          height: higth ?? 40,
          child: Center(
            child: Text(
              text ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
