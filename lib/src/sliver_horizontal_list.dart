import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

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
    Size deviceSize = MediaQuery.of(context).size;

    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 200,
        maxHeight: 300,
        child: Container(
          color: Colors.white10,
          child: NoSplash(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                // color: Colors.black12,
                margin: EdgeInsets.only(right: index == 9 ? 0 : 32),
                width: (deviceSize.width - 96) /
                    2, // position only 2 cards on screen at a time
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PlaceholderLines(
                        align: TextAlign.center,
                        minOpacity: 0.2,
                        maxOpacity: 0.5,
                        count: 2,
                        color: Colors.black26),
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
