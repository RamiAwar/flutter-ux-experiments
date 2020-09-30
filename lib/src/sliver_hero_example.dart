import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

import 'sliver_hero.dart';
import 'sliver_obstruction_injector.dart';

class SliverHeroExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool overlap) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverHero(
                avatar: SizedBox(),
                bottom: Placeholder(),
                expandedHeight: 400,
              ),
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverObstructionInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(16),
                      child: PlaceholderLines(
                        count: 2,
                        maxWidth: 0.8,
                        minWidth: 0.4,
                        align: TextAlign.left,
                        lineHeight: 8,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }, childCount: 25))
              ],
            );
          },
        ),
      ),
    );
  }
}
