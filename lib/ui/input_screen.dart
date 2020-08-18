import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/parts/input_1st_or_2nd_row.dart';
import 'package:tcg_recorder/ui/parts/input_game_row.dart';
import 'package:tcg_recorder/ui/parts/input_opponent_deck_row.dart';
import 'package:tcg_recorder/ui/parts/input_tag_row.dart';
import 'package:tcg_recorder/ui/parts/input_use_deck_row.dart';
import 'package:tcg_recorder/ui/parts/input_win_or_lose.dart';
import 'package:tcg_recorder/ui/parts/ok_button.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ入力'),
      ),
      body: const Center(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final column = Column(
      children: [
        const InputGameRow(),
        const InputTagRow(),
        const InputUseDeckRow(),
        const InputOpponentDeckRow(),
        const InputFirstOrSecondRow(),
        const InputWinOrLoseRow(),
        const OkButton(),
      ],
    );
    return Form(
      key: _formKey,
      child: column,
    );
  }
}
