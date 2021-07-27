import 'package:flutter/material.dart';
import '../style/index.dart' show CustomColors, CustomICons;

class ErrorPage extends StatefulWidget {
  final FlutterErrorDetails details;

  ErrorPage(this.details);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  final TextEditingController textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: CustomColors.primaryValue,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            gradient: RadialGradient(
              tileMode: TileMode.mirror,
              radius: 0.1,
              colors: [
                Colors.white.withAlpha(10),
                CustomColors.primaryValue.withAlpha(100),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(CustomICons.DEFAULT_USER_ICON),
                width: 90.0,
                height: 90.0,
              ),
              SizedBox(
                height: 11.0,
              ),
              Material(
                child: Text(
                  'Error Occur',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                color: CustomColors.primaryValue,
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(primary: CustomColors.white.withAlpha(100)),
                    onPressed: _errorReport,
                    child: Text('Report'),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: CustomColors.white.withAlpha(100)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Back'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _errorReport() {
    String content =
        '${widget.details.exception.toString()}\n${widget.details.stack.toString()}';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              color: Colors.yellowAccent,
              child: Text(content),
            ),
          );
        });
  }
}
