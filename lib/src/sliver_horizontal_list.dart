import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'no_splash.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  double shrinkRatio;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlap) {
    shrinkRatio = min(1.0, shrinkOffset / (maxExtent - minExtent));
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class SliverHorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 150,
        maxHeight: 260,
        child: Container(
          color: Colors.white10,
          child: NoSplash(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                margin: index == 9
                    ? EdgeInsets.symmetric(horizontal: 32)
                    : EdgeInsets.only(left: 32.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  width: 200,
                  child: Center(
                    child: Expanded(
                        child: Center(child: Container(child: Placeholder()))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
