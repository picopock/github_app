import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'
    show
        WebView,
        SurfaceAndroidWebView,
        JavascriptMode,
        AutoMediaPlaybackPolicy,
        NavigationRequest,
        NavigationDecision;
import '../../i10n/localization_intl.dart' show AppLocalizations;
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitDoubleBounce;

class LoginWebview extends StatefulWidget {
  final String url;
  final String title;

  LoginWebview(this.url, this.title);

  @override
  _LoginWebviewState createState() => _LoginWebviewState();
}

class _LoginWebviewState extends State<LoginWebview> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  Widget _renderTitle() {
    if (widget.url.length == 0) {
      return new Text(widget.title);
    }
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: _renderTitle()),
      body: Stack(
        children: <Widget>[
          WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              navigationDelegate: (NavigationRequest navigation) {
                if (navigation.url.startsWith("githubapp://authed")) {
                  var code = Uri.parse(navigation.url).queryParameters["code"];
                  print("code $code");
                  Navigator.of(context).pop(code);
                  return NavigationDecision.prevent; // 阻止继续重定向
                }
                return NavigationDecision.navigate; // 继续重定向
              },
              onPageFinished: (_) {
                setState(() {
                  isLoading = false;
                });
              }),
          if (isLoading)
            new Center(
              child: Container(
                child: Row(
                  children: <Widget>[
                    new SpinKitDoubleBounce(
                        color: Theme.of(context).primaryColor),
                    new Container(width: 10.0),
                    new Container(
                        child: new Text(
                      AppLocalizations.of(context).loading,
                    )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                width: 200,
                height: 200,
                padding: EdgeInsets.all(4),
              ),
            )
        ],
      ),
    );
  }
}
