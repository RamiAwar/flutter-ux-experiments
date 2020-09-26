import 'package:flutter/material.dart';

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

class _SliverBarState extends State<SliverBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.white,
            // Allows the user to reveal the app bar if they begin scrolling back
            // up the list of items.
            floating: true,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: Placeholder(),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 400,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text("Item #$index")),
                childCount: 100),
          ),
        ],
      ),
    );
  }
}
