import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcg_manager/generated/l10n.dart';

class CustomModalPicker extends StatelessWidget {
  const CustomModalPicker({
    required this.child,
    this.submitedAction,
    this.actionButton,
    this.shoModalButton = true,
    this.height,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final void Function()? submitedAction;
  final Widget? actionButton;
  final bool shoModalButton;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (shoModalButton)
            ModalButton(
              submitedAction: submitedAction != null ? submitedAction! : null,
              actionButton: actionButton,
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 6),
              color: Theme.of(context).canvasColor,
              child: SafeArea(
                top: false,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModalButton extends StatelessWidget {
  const ModalButton({
    this.submitedAction,
    this.actionButton,
    key,
  }) : super(key: key);
  final void Function()? submitedAction;
  final Widget? actionButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff999999),
            width: 0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: actionButton != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
        children: <Widget>[
          if (actionButton != null) actionButton!,
          CupertinoButton(
            onPressed: submitedAction != null ? submitedAction! : null,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            child: Text(S.of(context).submit),
          )
        ],
      ),
    );
  }
}
