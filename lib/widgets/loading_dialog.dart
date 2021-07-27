import 'package:flutter/material.dart' hide Router;
import '../style/index.dart' show CustomColors, Constant;
import '../i10n/localization_intl.dart' show AppLocalizations;
import '../widgets/spin_kit_cube_grid.dart' show SpinKitCubeGrid;
import '../route/index.dart' show Router;

class _LoadingWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Center(
          child: Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: SpinKitCubeGrid(color: CustomColors.white),
                ),
                Container(height: 10.0),
                Container(
                  child: Text(
                    AppLocalizations.of(context).loading,
                    style: Constant.normalTextWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Loading {
  static Future<_LoadingWidget?> show(BuildContext context,
      {bool barrierDismissible = true}) {
    return showDialog<_LoadingWidget>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                .copyWith(textScaleFactor: 1),
            child: SafeArea(
              child: _LoadingWidget(),
            ),
          );
        });
  }

  static hide(BuildContext context) {
    Router.pop(context);
  }
}
