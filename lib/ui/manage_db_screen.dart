import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/manage_db_model.dart';

class ManageDBScreen extends StatelessWidget {
  const ManageDBScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage DB'),
      ),
      body: const DBListView(),
    );
  }
}

class DBListView extends StatelessWidget {
  const DBListView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ManageDBModel>(context, listen: true);
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        RaisedButton(
            child: const Text('更新'),
            color: Colors.amber[800],
            textColor: Colors.white,
            onPressed: () => model.fetchAll()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
              children: [
                const Text('Record'),
                Container(
                  height: 180,
                  child: ListView.builder(
                    itemCount: model.allRecordList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          Text(model.allRecordList[index].recordId.toString()),
                          Text(model.allRecordList[index].title.toString()),
                          Text(model.allRecordList[index].numberPeople
                              .toString()),
                          Text(model.allRecordList[index].isEdit.toString()),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
              children: [
                const Text('Record Contents'),
                Container(
                  height: 180,
                  child: ListView.builder(
                    itemCount: model.allRecordContentsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          Text(model
                              .allRecordContentsList[index].recordContentsId
                              .toString()),
                          Text(model.allRecordContentsList[index].recordId
                              .toString()),
                          Text(model.allRecordContentsList[index].nameId
                              .toString()),
                          Text(model.allRecordContentsList[index].count
                              .toString()),
                          Text(model.allRecordContentsList[index].score
                              .toString()),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
              children: [
                const Text('Name'),
                Container(
                  height: 180,
                  child: ListView.builder(
                    itemCount: model.allNameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          Text(model.allNameList[index].nameId.toString()),
                          Text(model.allNameList[index].name.toString()),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
              children: [
                const Text('Correspondence'),
                Container(
                  height: 180,
                  child: ListView.builder(
                    itemCount: model.allCorrespondenceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          Text(model.allCorrespondenceList[index].mappingId
                              .toString()),
                          Text(model.allCorrespondenceList[index].nameId
                              .toString()),
                          Text(model.allCorrespondenceList[index].recordId
                              .toString()),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
