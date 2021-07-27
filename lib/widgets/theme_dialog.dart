import 'package:flutter/material.dart';

import './flex_theme_button.dart' show FlexThemeButton;

class ThemeDialog extends StatelessWidget {
  final onPressed;

  ThemeDialog({Key? key, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlexThemeButton(
              color: Colors.black,
              onPressed: onPressed(Colors.black),
            ),
            FlexThemeButton(
              color: Colors.brown,
              onPressed: onPressed(Colors.brown),
            ),
            FlexThemeButton(
              color: Colors.blueAccent,
              onPressed: onPressed(Colors.blueAccent),
            ),
            FlexThemeButton(
              color: Colors.greenAccent,
              onPressed: onPressed(Colors.greenAccent),
            ),
            FlexThemeButton(
              color: Colors.yellow,
              onPressed: onPressed(Colors.yellow),
            ),
            FlexThemeButton(
              color: Colors.pinkAccent,
              onPressed: onPressed(Colors.pinkAccent),
            ),
            FlexThemeButton(
              color: Colors.redAccent,
              onPressed: onPressed(Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
