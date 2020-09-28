import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

void main() {
  runApp(SliverBarExample());
}

class SliverBarExample extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SliverBar(title: 'Sliver Bar Example');
  }
}

class SliverBar extends StatefulWidget {
  SliverBar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SliverBarState createState() => _SliverBarState();
}

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
    return SizedBox.expand(
        child: Opacity(opacity: 1 - shrinkRatio, child: child));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class SliverObstructionInjector extends SliverOverlapInjector {
  /// Creates a sliver that is as tall as the value of the given [handle]'s
  /// layout extent.
  ///
  /// The [handle] must not be null.
  const SliverObstructionInjector({
    Key key,
    @required SliverOverlapAbsorberHandle handle,
    Widget child,
  })  : assert(handle != null),
        super(key: key, handle: handle, sliver: child);

  @override
  RenderSliverObstructionInjector createRenderObject(BuildContext context) {
    return new RenderSliverObstructionInjector(
      handle: handle,
    );
  }
}

/// A sliver that has a sliver geometry based on the values stored in a
/// [SliverOverlapAbsorberHandle].
///
/// The [RenderSliverOverlapAbsorber] must be an earlier descendant of a common
/// ancestor [RenderViewport] (probably a [RenderNestedScrollViewViewport]), so
/// that it will always be laid out before the [RenderSliverObstructionInjector]
/// during a particular frame.
class RenderSliverObstructionInjector extends RenderSliverOverlapInjector {
  /// Creates a sliver that is as tall as the value of the given [handle]'s extent.
  ///
  /// The [handle] must not be null.
  RenderSliverObstructionInjector({
    @required SliverOverlapAbsorberHandle handle,
    RenderSliver child,
  })  : assert(handle != null),
        _handle = handle,
        super(handle: handle);

  double _currentLayoutExtent;
  double _currentMaxExtent;

  /// The object that specifies how wide to make the gap injected by this render
  /// object.
  ///
  /// This should be a handle owned by a [RenderSliverOverlapAbsorber] and a
  /// [RenderNestedScrollViewViewport].
  SliverOverlapAbsorberHandle get handle => _handle;
  SliverOverlapAbsorberHandle _handle;
  set handle(SliverOverlapAbsorberHandle value) {
    assert(value != null);
    if (handle == value) return;
    if (attached) {
      handle.removeListener(markNeedsLayout);
    }
    _handle = value;
    if (attached) {
      handle.addListener(markNeedsLayout);
      if (handle.layoutExtent != _currentLayoutExtent ||
          handle.scrollExtent != _currentMaxExtent) markNeedsLayout();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    handle.addListener(markNeedsLayout);
    if (handle.layoutExtent != _currentLayoutExtent ||
        handle.scrollExtent != _currentMaxExtent) markNeedsLayout();
  }

  @override
  void performLayout() {
    _currentLayoutExtent = handle.layoutExtent;
    _currentMaxExtent = handle.layoutExtent;
    geometry = new SliverGeometry(
      scrollExtent: 0.0,
      paintExtent: _currentLayoutExtent,
      maxPaintExtent: _currentMaxExtent,
    );
  }
}

class _SliverBarState extends State<SliverBar> {
  @override
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
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: Placeholder(),
                // forceElevated: innerBoxIsScrolled,
                elevation: 0,
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 400,
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverObstructionInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 150,
                  maxHeight: 300,
                  child: Container(
                    color: Colors.blue,
                    padding:
                        EdgeInsets.symmetric(vertical: 46.0, horizontal: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: 200,
                          height: 150,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Card"),
                                Expanded(
                                  child: Center(
                                    child: Stack(children: [
                                      Center(child: Icon(Icons.access_alarm)),
                                      Placeholder(),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(title: Text("Item #$index")),
                    childCount: 20),
              ),
            ],
          );
        }),
      ),
    );
  }
}
