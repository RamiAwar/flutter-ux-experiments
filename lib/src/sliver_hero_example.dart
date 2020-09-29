import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

import 'sliver_hero.dart';

class SliverHeroExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool overlap) {
            return <Widget>[
              SliverHero(
                avatar: CircleAvatar(radius: 30),
                bottom: Placeholder(),
                expandedHeight: 400,
              ),
              // SliverAppBar()
            ];
          },
          body: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  title: PlaceholderLines(
                    count: 2,
                    maxWidth: 0.8,
                    minWidth: 0.4,
                    align: TextAlign.left,
                    lineHeight: 8,
                    color: Colors.grey,
                  ),
                );
              }, childCount: 25))
            ],
          )),
    );
  }
}
