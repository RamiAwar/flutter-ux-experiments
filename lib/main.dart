import 'package:flutter/material.dart';

import 'src/sliver_categories.dart';
import 'src/sliver_nested.dart';

void main() => runApp(AnimationSamples());

class Demo {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Demo({this.name, this.route, this.builder});
}

final basicDemos = [
  Demo(
      name: 'Sliver Categories',
      route: 'src/sliver_categories',
      builder: (context) => SliverCategories()),
  // Demo(
  //     name: 'Temp',
  //     route: 'src/sliver_nested.dart',
  //     builder: (context) => MyApp()),
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
      body: SafeArea(
        child: GridView.count(
          padding: EdgeInsets.all(16.0),
          crossAxisCount: 2,
          children: basicDemos.map((d) => DemoTile(d)).toList(),
        ),
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
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: ListTile(
          title: Center(
            child: Text(demo.name),
          ),
          onTap: () {
            Navigator.pushNamed(context, demo.route);
          },
        ),
      ),
    );
  }
}
