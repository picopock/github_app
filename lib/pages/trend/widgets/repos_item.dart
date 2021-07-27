import 'package:flutter/material.dart' hide Router;

import '../../../utils/index.dart' show Utils;
import '../../../widgets/card_item.dart' show CustomCardItem;
import '../../../widgets/user_avatar.dart' show UserAvatar;
import '../../../route/index.dart' show Router;
import '../../../style/index.dart' show Constant, CustomICons, CustomColors;
import '../../../widgets/icon_text.dart' show IConText;

class ReposItem extends StatelessWidget {
  final ReposViewModel reposViewModel;
  final VoidCallback? onPressed;

  ReposItem(this.reposViewModel, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomCardItem(
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.only(
                left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UserAvatar(
                      reposViewModel.ownerPic!,
                      padding: const EdgeInsets.only(
                          top: 0.0, right: 5.0, left: 0.0),
                      width: 40.0,
                      height: 40.0,
                      onPressed: () {
                        Router.goPerson(context, reposViewModel.ownerName);
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(reposViewModel.repositoryName ?? '',
                              style: Constant.normalTextBold),
                          IConText(
                            CustomICons.REPOS_ITEM_USER,
                            reposViewModel.ownerName,
                            Constant.smallSubLightText,
                            CustomColors.subLightTextColor,
                            10.0,
                            padding: 3.0,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      reposViewModel.repositoryType,
                      style: Constant.smallSubText,
                    ),
                  ],
                ),
                reposViewModel.repositoryDesc!.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          reposViewModel.repositoryDesc!,
                          style: Constant.smallSubText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Container(),
                Padding(padding: const EdgeInsets.only(bottom: 10.0)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _renderBottomItem(context, CustomICons.REPOS_ITEM_STAR,
                        reposViewModel.repositoryStar!),
                    SizedBox(
                      width: 5.0,
                    ),
                    _renderBottomItem(context, CustomICons.REPOS_ITEM_FORK,
                        reposViewModel.repositoryFork!),
                    SizedBox(
                      width: 5.0,
                    ),
                    _renderBottomItem(context, CustomICons.REPOS_ITEM_ISSUE,
                        reposViewModel.repositoryWatch!,
                        flex: 4),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderBottomItem(BuildContext context, IconData icon, String text,
      {int flex = 3}) {
    return Expanded(
        flex: flex,
        child: Center(
          child: IConText(
            icon,
            text,
            Constant.smallSubText,
            CustomColors.subTextColor,
            15.0,
            padding: 5.0,
            textWidth: flex == 4
                ? (MediaQuery.of(context).size.width - 100) / 3
                : (MediaQuery.of(context).size.width - 100) / 5,
          ),
        ));
  }
}

class ReposViewModel {
  String? ownerName;
  String? ownerPic;
  String? repositoryName;
  String? repositoryStar;
  String? repositoryFork;
  String? repositoryWatch;
  String? hideWatchIcon;
  String repositoryType = '';
  String? repositoryDesc;

  ReposViewModel();

  ReposViewModel.fromTrendMap(data) {
    ownerName = data.name;
    if (data.contributors.length > 0) {
      ownerPic = data.contributors[0];
    } else {
      ownerPic = '';
    }

    repositoryName = data.reposName;
    repositoryStar = data.starCount;
    repositoryFork = data.forkCount;
    repositoryWatch = data.meta;
    repositoryType = data.language;
    repositoryDesc = Utils.removeTextTag(data.description);
  }
}
