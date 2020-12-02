import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/parts/toggle_switch.dart';

// class InputFirstOrSecondRow extends StatelessWidget {
//   const InputFirstOrSecondRow({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final _size = MediaQuery.of(context).size;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: _size.height * (9 / 100),
//           width: _size.width * (40 / 100),
//           margin: const EdgeInsets.all(0),
//           padding: const EdgeInsets.only(top: 10, bottom: 10),
//           child: RaisedButton(
//             color: const Color(0xFF5660BB),
//             onPressed: context.select((RecordModel model) => model.firstOrSecond)
//                 ? null
//                 : () {
//                     context.read<RecordModel>().changeFirstOrSecond();
//                   },
//             child: Text(
//               L10n.of(context).first,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//                 // fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         Container(
//           height: _size.height * (9 / 100),
//           width: _size.width * (40 / 100),
//           margin: const EdgeInsets.all(0),
//           padding: const EdgeInsets.only(top: 10, bottom: 10),
//           child: RaisedButton(
//             color: const Color(0xFF5660BB),
//             onPressed: !context.select((RecordModel model) => model.firstOrSecond)
//                 ? null
//                 : () {
//                     context.read<RecordModel>().changeFirstOrSecond();
//                   },
//             child: Text(
//               L10n.of(context).second,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//                 // fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class InputFirstOrSecondRow extends StatelessWidget {
  const InputFirstOrSecondRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _firstOrSecond = context.select((RecordModel model) => model.firstOrSecond);
    return ToggleSwitch(
      initialLabelIndex: _firstOrSecond ? 1 : 0,
      minWidth: _size.width * (40 / 100),
      minHeight: _size.height * (6 / 100),
      labels: [L10n.of(context).first, L10n.of(context).second],
      activeFgColor: Colors.white,
      inactiveFgColor: Colors.white,
      activeBgColor: const Color(0xFF6869a8),
      onToggle: (index) {
        context.read<RecordModel>().changeFirstOrSecond(index);
      },
      fontWeight: FontWeight.bold,
    );
  }
}
