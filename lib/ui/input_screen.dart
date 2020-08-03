import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ入力'),
      ),
      body: Center(
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
    final _gameController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.settings),
              border: OutlineInputBorder(),
              labelText: "ゲーム名",
              hintText: 'Enter your email',
            ),
            autovalidate: false,
            controller: _gameController,
            validator: (value) {
              if (value.isEmpty) {
                return '入力されていません';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class _InputGame extends StatelessWidget {
  const _InputGame({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.settings),
        border: OutlineInputBorder(),
        labelText: "ゲーム名",
        hintText: 'Enter your email',
      ),
      autovalidate: false,
      controller: _controller,
      validator: (value) {
        if (value.isEmpty) {
          return '入力されていません';
        }
        return null;
      },
    );
  }
}
