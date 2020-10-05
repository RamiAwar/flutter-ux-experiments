import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Experiment {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Experiment({this.name, this.route, this.builder});
}

class ExperimentTile extends StatelessWidget {
  final Experiment experiment;

  ExperimentTile(this.experiment);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Center(
        child: ListTile(
          title: Center(
            child: Text(
              experiment.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, experiment.route);
          },
        ),
      ),
    );
  }
}
