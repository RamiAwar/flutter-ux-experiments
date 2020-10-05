import 'package:flutter/material.dart';
import 'src/sliver_hero_example.dart';

import 'src/sliver_categories.dart';
import 'src/temp.dart';
import 'src/experiment_tile.dart';

void main() => runApp(AnimationSamples());

final basicDemos = [
  Experiment(
      name: 'Sliver Category',
      route: 'src/sliver_categories',
      builder: (context) => SliverCategories()),
  Experiment(
      name: 'Sliver Hero',
      route: 'src/sliver_hero_example',
      builder: (context) => SliverHeroExample()),
  // Demo(name: '')
  // Demo(
  //     name: 'Temp', route: 'src/temp.dart', builder: (context) => SendScreen()),
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
              children: basicDemos.map((d) => ExperimentTile(d)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
