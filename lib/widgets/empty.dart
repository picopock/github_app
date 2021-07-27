import 'package:flutter/material.dart';
import '../style/index.dart' show Constant, CustomICons;
import '../i10n/localization_intl.dart' show AppLocalizations;

class Empty extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final Image? image;
  final VoidCallback? onPressed;

  Empty({
    this.width,
    this.height,
    this.text,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double statusBar =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).padding.top;
    double bottomArea =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .padding
            .bottom;
    double _height = MediaQuery.of(context).size.height -
        statusBar -
        bottomArea -
        kBottomNavigationBarHeight -
        kToolbarHeight;
    double _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        height: height ?? _height,
        width: width ?? _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: image ??
                  Image(
                    image: AssetImage(CustomICons.DEFAULT_USER_ICON),
                    width: 70.0,
                    height: 70.0,
                  ),
              onPressed: onPressed ?? () {},
            ),
            Container(
              child: Text(
                text ?? AppLocalizations.of(context).noData,
                style: Constant.normalText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
