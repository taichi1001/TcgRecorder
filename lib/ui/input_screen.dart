import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_1st_or_2nd_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_game_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_opponent_deck_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_use_deck_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_win_or_lose.dart';
import 'package:tcg_recorder/ui/parts/input_screen/ok_button.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).inputScreenTitle),
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
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Column(
              children: const [
                InputGameRow(),
                // InputTagRow(),
                InputUseDeckRow(),
                InputOpponentDeckRow(),
                InputFirstOrSecondRow(),
                InputWinOrLoseRow(),
                OkButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
