import 'package:flutter/material.dart';

class FlexThemeButton extends StatelessWidget {
  final onPressed;
  final Color? color;

  FlexThemeButton({Key? key, @required this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              child: Text(''),
              onPressed: onPressed,
              style: TextButton.styleFrom(primary: color)
            ),
          )
        ],
      ),
    );
  }
}
