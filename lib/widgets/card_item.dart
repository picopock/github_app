import 'package:flutter/material.dart';
import '../style/index.dart' show CustomColors;

class CustomCardItem extends StatelessWidget {
  final Widget? child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;

  CustomCardItem({
    @required this.child,
    this.margin = const EdgeInsets.all(10.0),
    this.color = CustomColors.cardWhite,
    this.shape= const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    this.elevation = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: this.elevation,
      shape: this.shape,
      color: this.color,
      margin: this.margin,
      child: this.child,
    );
  }
}
