import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function onChanged;
  final Function validate;
  final Function onTab;
  final Function onSubmitted;
  final Widget icon;
  final Widget suffixIcon;
  final double width;
  final double height;
  final TextInputType inputType;
  final String label;
  final String hint;
  final int lines;
  final bool secureText;
  final double raduis;
  final String initialText;
  final TextEditingController controller;

  const CustomTextField({
    Key key,
    this.onChanged,
    this.validate,
    this.icon,
    this.width,
    this.height,
    this.inputType,
    this.label,
    this.hint,
    this.lines,
    this.secureText,
    this.raduis,
    this.initialText,
    this.onTab,
    this.onSubmitted,
    this.controller,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: width,
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
        height: height,
        child: TextFormField(
            controller: controller,
            onFieldSubmitted: onSubmitted,
            onTap: onTab,
            maxLines: lines ?? 1,
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 11.0),
            obscureText: secureText ?? false,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: inputType ?? TextInputType.multiline,
            validator: validate,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(raduis ?? 10),
                  borderSide: BorderSide(
                    color: Colors.grey[500],
                  ),
                ),
                errorStyle: TextStyle(fontSize: 10.0),
                contentPadding: EdgeInsets.only(
                    right: 20.0, top: 10.0, bottom: 10.0, left: 20),
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(raduis ?? 10),
                  borderSide:
                      new BorderSide(color: Theme.of(context).primaryColor),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                prefixIcon: icon,
                suffixIcon: suffixIcon ?? null,
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                hintText: label),
            onChanged: onChanged),
      ),
    );
  }
}
