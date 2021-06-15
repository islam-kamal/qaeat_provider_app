import 'package:Qaeat_Provider/Helper/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width, higth, opacity, raduis;
  final String text;
  final Color color, textColor;

  const CustomButton(
      {Key key,
      this.width,
      this.higth,
      this.text,
      this.opacity,
      this.raduis,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            color: color ?? QaeatColor.primary_color,
            borderRadius: BorderRadius.circular(10)),
        width: width ?? double.infinity,
        height: higth ?? 45,
        child: Center(
          child: Text(
            text ?? "",
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
