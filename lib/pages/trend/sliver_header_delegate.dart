import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show FloatingHeaderSnapConfiguration;
import 'dart:math' show max;

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double? maxHeight;
  final Widget? child;
  final Builder? builder;
  final bool changeSize;
  final FloatingHeaderSnapConfiguration? snapConfig;
  late AnimationController animationController;

  SliverHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.snapConfig,
    this.child,
    this.builder,
    this.changeSize = false,
  });

  @override
  double get minExtent => minHeight!;

  @override
  double get maxExtent => max(maxHeight!, minHeight!);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (builder != null) {
      return builder!(context, shrinkOffset, overlapsContent);
    }
    return child!;
  }

  @override
  bool shouldRebuild(SliverHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => snapConfig!;
}

typedef Widget Builder(
    BuildContext context, double shrinkOffset, bool overlapsContent);
