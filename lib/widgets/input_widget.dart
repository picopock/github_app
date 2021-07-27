import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  final bool obscureText;
  final String? hintText;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final bool autofocus;

  CustomInputWidget({
    Key? key,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.controller,
    this.obscureText = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  State<CustomInputWidget> createState() {
    return _CustomInputWidgetState();
  }
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  _CustomInputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : Icon(widget.iconData),
      ),
    );
  }
}
