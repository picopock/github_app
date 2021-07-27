import 'package:flutter/material.dart' hide Router;

import '../../../widgets/card_item.dart' show CustomCardItem;
import '../../../widgets/user_avatar.dart' show UserAvatar;
import '../../../route/index.dart' show Router;
import '../../../style/index.dart' show Constant;

class EventItem extends StatelessWidget {
  final data;
  final VoidCallback? onPressed;
  final bool showAvatar;
  EventItem(this.data, {this.onPressed, this.showAvatar = true});

  Widget build(BuildContext context) {
    return Container(
      child: CustomCardItem(
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _renderAvatar(context), // 头像
                      Expanded(
                        child: Text(data.actionUser ?? '',
                            style: Constant.smallTextBold),
                      ),
                      Text(data.actionTime ?? '', style: Constant.smallSubText),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                    alignment: Alignment.topLeft,
                    child:
                        Text(data.actionTarget, style: Constant.smallTextBold),
                  ),
                  _renderDesc(context),
                ],
              )),
        ),
      ),
    );
  }

  _renderAvatar(BuildContext context) {
    return showAvatar
        ? UserAvatar(
            data.actionUserPic,
            width: 30.0,
            height: 30.0,
            onPressed: () {
              Router.goPerson(context, data.actionUser);
            },
          )
        : Container();
  }

  _renderDesc(BuildContext context) {
    if (data.actionDes == null || data.actionDes.length == 0) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
      alignment: Alignment.topLeft,
      child: Text(
        data.actionDes,
        style: Constant.smallSubText,
        maxLines: 3,
      ),
    );
  }
}
