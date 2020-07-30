import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/graph_screen.dart';

class SelectChartScreen extends StatelessWidget {
  const SelectChartScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Chart'),
      ),
      body: const ChartListView(),
    );
  }
}

class ChartListView extends StatelessWidget {
  const ChartListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagModel = Provider.of<TagModel>(context, listen: true);
    if (tagModel.allTagList.isEmpty) {
      return const Center(child: Text('No Tags'));
    }

    return ListView.builder(
      itemCount: tagModel.allTagList.length,
      itemBuilder: (BuildContext context, int index) {
        final graphModel = GraphModel(tagModel.allTagList[index].tag);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: graphModel),
          ],
          child: const ChartListTile(),
        );
      },
    );
  }
}

class ChartListTile extends StatelessWidget {
  const ChartListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagName = context.select((GraphModel value) => value.selectTagName);
    return Card(
      child: Consumer<GraphModel>(
        builder: (context, graphModel, _) => ListTile(
          title: Text(tagName),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: graphModel),
                  ],
                  child: const ChartScreen(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
