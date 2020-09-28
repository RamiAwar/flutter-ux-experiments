import 'dart:math';

import 'package:flutter/material.dart';

import 'no_splash.dart';
import 'sliver_horizontal_list.dart';
import 'sliver_obstruction_injector.dart';

import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class SliverCategories extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool overlap) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                collapsedHeight: 80,
                pinned: true,
                leading: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: Colors.white,
                flexibleSpace: Placeholder(),
                elevation: 0,
                expandedHeight: 400,
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return NoSplash(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverObstructionInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                SliverHorizontalListView(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                            title: PlaceholderLines(
                              count: 2,
                              maxWidth: 0.8,
                              minWidth: 0.4,
                              align: TextAlign.left,
                              lineHeight: 8,
                              color: Colors.grey,
                            ),
                          ),
                      childCount: 20),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
