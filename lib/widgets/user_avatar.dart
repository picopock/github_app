import 'package:flutter/material.dart';
import '../style/index.dart' show CustomICons;

class UserAvatar extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  UserAvatar(
    this.avatarUrl, {
    this.onPressed,
    this.width = 30.0,
    this.height = 30.0,
    this.padding = const EdgeInsets.only(top: 4.0, right: 5.0, left: 0.0),
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: padding,
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: ClipOval(
        child: FadeInImage(
          placeholder: AssetImage(CustomICons.DEFAULT_USER_ICON),
          image: NetworkImage(avatarUrl),
          // 预览图
          fit: BoxFit.fitWidth,
          width: width,
          height: height,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
