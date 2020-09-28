/// Flutter code sample for NestedScrollView

// This example shows a [NestedScrollView] whose header is the combination of a
// [TabBar] in a [SliverAppBar] and whose body is a [TabBarView]. It uses a
// [SliverOverlapAbsorber]/[SliverOverlapInjector] pair to make the inner lists
// align correctly, and it uses [SafeArea] to avoid any horizontal disturbances
// (e.g. the "notch" on iOS when the phone is horizontal). In addition,
// [PageStorageKey]s are used to remember the scroll position of each tab's
// list.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = ['Tab 1', 'Tab 2'];
    return DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            title: const Text('Books'), // This is the title in the app bar.
            pinned: true,
            expandedHeight: 150.0,
            // The "forceElevated" property causes the SliverAppBar to show
            // a shadow. The "innerBoxIsScrolled" parameter is true when the
            // inner scroll view is scrolled beyond its "zero" point, i.e.
            // when it appears to be scrolled below the SliverAppBar.
            // Without this, there are cases where the shadow would appear
            // or not appear inappropriately, because the SliverAppBar is
            // not actually aware of the precise position of the inner
            // scroll views.
            bottom: TabBar(
              // These are the widgets to put in each tab in the tab bar.
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
            ),
          ),
          SliverToBoxAdapter(
            child: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return ListTile(
                                    title: Text('Item $index'),
                                  );
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ]));
  }
}
