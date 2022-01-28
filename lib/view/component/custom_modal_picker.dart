import 'package:flutter/cupertino.dart';

class CustomModalPicker extends StatelessWidget {
  const CustomModalPicker({
    required this.child,
    this.submitedAction,
    this.actionButton,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final void Function()? submitedAction;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ModalButton(
            submitedAction: submitedAction != null ? submitedAction! : null,
            actionButton: actionButton,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 6),
              color: CupertinoColors.white,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 22,
                ),
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalButton extends StatelessWidget {
  const _ModalButton({
    this.submitedAction,
    this.actionButton,
    key,
  }) : super(key: key);
  final void Function()? submitedAction;
  final Widget? actionButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        border: Border(
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
            child: const Text('決定'),
          )
        ],
      ),
    );
  }
}
