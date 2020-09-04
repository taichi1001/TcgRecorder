import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/record_model.dart';

class InputFirstOrSecondRow extends StatelessWidget {
  const InputFirstOrSecondRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: _size.height * (10 / 100),
          width: _size.width * (40 / 100),
          margin: const EdgeInsets.only(right: 3),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: RaisedButton(
            onPressed: context.select((RecordModel model) => model.firstOrSecond) == 1
                ? null
                : () {
                    context.read<RecordModel>().changeFirstOrSecond();
                  },
            child: const Text('1st'),
          ),
        ),
        Container(
          height: _size.height * (10 / 100),
          width: _size.width * (40 / 100),
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: RaisedButton(
            onPressed: context.select((RecordModel model) => model.firstOrSecond) == 2
                ? null
                : () {
                    context.read<RecordModel>().changeFirstOrSecond();
                  },
            child: const Text('2nd'),
          ),
        ),
      ],
    );
  }
}
