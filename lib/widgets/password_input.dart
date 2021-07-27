import 'package:flutter/material.dart';

class CustomPasswordInput extends StatefulWidget {
  final bool obscureText;
  final String? hintText;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final TextEditingController? controller;

  CustomPasswordInput({
    Key? key,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.controller,
    this.obscureText = true,
  }) : super(key: key);

  @override
  State<CustomPasswordInput> createState() {
    return _CustomPasswordInputState(obscureText: obscureText);
  }
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool? obscureText;
  _CustomPasswordInputState({ @required this.obscureText }) : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: obscureText!,
          decoration: InputDecoration(
            hintText: widget.hintText,
            icon: widget.iconData == null ? null : Icon(widget.iconData),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText!;
            });
          },
          child: Icon(
            obscureText! ? Icons.visibility_off : Icons.visibility,
          ),
        )
      ],
    );
  }
}
