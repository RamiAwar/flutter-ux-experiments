import 'package:flutter/material.dart';
import 'src/sliver_hero_example.dart';

import 'src/sliver_categories.dart';
import 'src/temp.dart';

void main() => runApp(AnimationSamples());

class Demo {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Demo({this.name, this.route, this.builder});
}

final basicDemos = [
  Demo(
      name: 'Sliver Category',
      route: 'src/sliver_categories',
      builder: (context) => SliverCategories()),
  Demo(
      name: 'Sliver Hero',
      route: 'src/sliver_hero_example',
      builder: (context) => SliverHeroExample()),
  Demo(name: 'Temp', route: 'src/temp.dart', builder: (context) => MyApp()),
];

final basicDemoRoutes =
    Map.fromEntries(basicDemos.map((d) => MapEntry(d.route, d.builder)));

final allRoutes = <String, WidgetBuilder>{
  ...basicDemoRoutes,
};

class AnimationSamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation Samples',
      routes: allRoutes,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: basicDemos.map((d) => DemoTile(d)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DemoTile extends StatelessWidget {
  final Demo demo;

  DemoTile(this.demo);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Center(
        child: ListTile(
          title: Center(
            child: Text(
              demo.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, demo.route);
          },
        ),
      ),
    );
  }
}
