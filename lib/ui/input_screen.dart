import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_1st_or_2nd_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_game_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_opponent_deck_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_use_deck_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_tag_row.dart';
import 'package:tcg_recorder/ui/parts/input_screen/input_win_or_lose.dart';
import 'package:tcg_recorder/ui/parts/input_screen/ok_button.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          title: Text(
            L10n.of(context).inputScreenTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      InputGameRow(),
                      InputUseDeckRow(),
                      InputOpponentDeckRow(),
                      // InputTagRow(),
                      InputFirstOrSecondRow(),
                      InputWinOrLoseRow(),
                    ],
                  ),
                ),
              ),
            ),
            const OkButton(),
          ],
        ),
      ),
    );
  }
}
