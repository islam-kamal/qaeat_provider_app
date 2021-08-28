import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Function value;
  final Function validate;
  final Function onTab;
  final Function onSubmitted;
  final Widget icon;
  final Widget suffix;
  final double width;
  final double height;
  final TextInputType inputType;
  final String label;
  final String hint;
  final int lines;
  final bool secureText;
  final double raduis;
  final String initialText;

  const CustomTextField({
    Key key,
    this.value,
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
    this.suffix,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: widget.width,
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
        height: widget.height,
        child: TextFormField(
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTab,
          initialValue: widget.initialText ?? "",
          maxLines: widget.lines ?? 1,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 11.0),
          obscureText: widget.secureText ?? false,
          cursorColor: Theme.of(context).accentColor,
          keyboardType: widget.inputType ?? TextInputType.multiline,
          validator: widget.validate,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.raduis ?? 10),
                borderSide: BorderSide(
                  color: Colors.grey[500],
                ),
              ),
              errorStyle: TextStyle(color: Colors.red, fontSize: 10.0),
              contentPadding: EdgeInsets.only(
                  right: 20.0, top: 10.0, bottom: 10.0, left: 20),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(widget.raduis ?? 10.0),
                borderSide: new BorderSide(color: Colors.grey),
              ),
              suffixIcon: widget.suffix,
              prefixIcon: widget.icon,
              labelText: widget.label,
              labelStyle: TextStyle(
                  fontSize: 12, color: Theme.of(context).primaryColor),
              hintStyle: TextStyle(
                  fontSize: 12, color: Colors.grey),
              hintText: widget.hint),
          onChanged: widget.value,
        ),
      ),
    );
  }
}
