import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/repository/firestore_invite_code_repository.dart';
import 'package:flutter/services.dart';

Future inviteCodeDialog(BuildContext context, InviteCode code) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return InviteCodeModal(code: code);
    },
  );
}

class InviteCodeModal extends HookConsumerWidget {
  const InviteCodeModal({
    required this.code,
    super.key,
  });

  final InviteCode code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    return Dialog(
      surfaceTintColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text('招待コード', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              Text(code.code, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('有効期限：${dateFormat.format(code.expiresAt)}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    onPressed: () async {
                      Clipboard.setData(ClipboardData(text: code.code));
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.copy),
                        const SizedBox(width: 8),
                        Text(
                          'コピーする',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
