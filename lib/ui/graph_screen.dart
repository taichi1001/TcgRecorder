import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:charts_flutter/flutter.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final graphModel = Provider.of<GraphModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(graphModel.selectTagName),
      ),
      body: const Chart(),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final graphModel = Provider.of<GraphModel>(context, listen: true);
    if (graphModel.scoreMap.isEmpty) {
      return const Text('Non Data');
    } else {
      return Text(graphModel.scoreMap.toString());
    }
  }
}
