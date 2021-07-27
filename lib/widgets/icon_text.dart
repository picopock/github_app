import 'package:flutter/material.dart';

class IConText extends StatelessWidget {
  final IconData iconData;
  final String? iconText;
  final TextStyle textStyle;
  final Color iconColor;
  final double padding;
  final double iconSize;
  final VoidCallback? onPressed;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double textWidth;

  IConText(
    this.iconData,
    this.iconText,
    this.textStyle,
    this.iconColor,
    this.iconSize, {
    this.padding = 0.0,
    this.onPressed,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.textWidth = -1.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget text = textWidth == -1
        ? new Container(
            child: Text(
              iconText ?? '',
              style: textStyle.merge(
                new TextStyle(
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        : Container(
            width: textWidth,
            child: Text(
              iconText ?? '',
              style: textStyle
                  .merge(new TextStyle(textBaseline: TextBaseline.alphabetic)),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
    return Container(
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          Icon(iconData, size: iconSize, color: iconColor),
          Padding(padding: EdgeInsets.all(padding)),
          text,
        ],
      ),
    );
  }
}
