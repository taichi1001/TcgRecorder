import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GraphScreen extends StatelessWidget {
  const GraphScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('グラフ'),
      ),
      body: Center(child: Text('グラフ'),),
    );
  }
}