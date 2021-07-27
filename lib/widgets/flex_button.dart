import 'dart:ui';

import 'package:flutter/material.dart';

class CustomFlexButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPress;
  final double? fontSize;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;

  CustomFlexButton({
    Key? key,
    @required this.text,
    @required this.color,
    @required this.textColor,
    this.onPress,
    this.fontSize,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color, padding:
          const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
          textStyle: TextStyle(color: textColor)
      ),
      child: Flex(
        mainAxisAlignment: mainAxisAlignment,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: Text(
              text!,
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      onPressed: () {
        this.onPress?.call();
      },
    );
  }
}
