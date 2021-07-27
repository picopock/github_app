import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  static const String path = 'mine';
  @override
  _MinePageState createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage>
/* with AutomaticKeepAliveClientMixin<DynamicPage> */ {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      child: Center(
        child: Text('Mine Page'),
      ),
    );
  }
}
