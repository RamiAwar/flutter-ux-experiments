import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SliverHero extends StatelessWidget {
  final Widget avatar;
  final Widget bottom;
  final double expandedHeight;
  final double collapsedHeight;
  final bool pinned;

  SliverHero(
      {this.avatar,
      this.bottom,
      this.pinned = true,
      this.expandedHeight = 200,
      this.collapsedHeight = 120,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: pinned,
        delegate: _SliverHeroDelegate(
            avatar: avatar,
            bottom: bottom,
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight));
  }
}

class _SliverHeroDelegate extends SliverPersistentHeaderDelegate {
  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.centerLeft);
  final _avatarPaddingTween =
      EdgeInsetsTween(begin: EdgeInsets.all(16), end: EdgeInsets.all(16));

  final Widget leading;
  final Widget avatar;
  final Widget bottom;
  final double expandedHeight;
  final double collapsedHeight;

  _SliverHeroDelegate(
      {this.leading,
      this.avatar,
      this.bottom,
      this.expandedHeight = 250,
      this.collapsedHeight = 120})
      : assert(avatar != null),
        assert(bottom != null),
        assert(expandedHeight == null || expandedHeight > 200);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Get fraction shrinked
    final progress = min(1.0, shrinkOffset / (maxExtent - minExtent));

    final _avatarAlign = _avatarAlignTween.lerp(progress);
    final _avatarPadding = _avatarPaddingTween.lerp(progress);

    return Container(
        color: Colors.blue,
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: _avatarAlign,
                child: Padding(
                  padding: _avatarPadding,
                  child: avatar,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(_SliverHeroDelegate oldDelegate) {
    // return avatar != oldDelegate.avatar || bottom != oldDelegate.bottom;
    return true;
  }
}
