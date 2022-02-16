import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.onChanged,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              // width: 330,
              // height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE6E6E6),
                ),
              ),
              child: Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: TextFormField(
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: keyboardType,
                    maxLines: maxLines,
                    style: const TextStyle(fontSize: 16),
                    obscureText: false,
                    cursorColor: const Color(0xFF18204E),
                    decoration: InputDecoration(
                      labelText: labelText,
                      labelStyle: const TextStyle(fontSize: 12),
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF18204E),
                        fontSize: 10,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
