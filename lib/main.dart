import 'package:flutter/material.dart';

import 'src/sliver_app_bar.dart';
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
      name: 'Sliver Bar',
      route: 'src/sliver_app_bar',
      builder: (context) => SliverBarExample()),
  Demo(
      name: 'Temp',
      route: 'src/sliver_nested.dart',
      builder: (context) => MyApp()),
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
      title: 'Animation Samples',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: allRoutes,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
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
    return Card(
      child: Container(
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
      ),
    );
  }
}
