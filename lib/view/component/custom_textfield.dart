import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.onTap,
    this.labelText,
    this.controller,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String? labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: 330,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFE6E6E6),
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: TextFormField(
                    controller: controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: labelText,
                      // labelStyle: FlutterFlowTheme.bodyText2.override(
                      //   fontFamily: 'Montserrat',
                      //   color: Color(0xFF8B97A2),
                      //   fontWeight: FontWeight.w500,
                      // ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    // style: FlutterFlowTheme.bodyText2.override(
                    //   fontFamily: 'Montserrat',
                    //   color: Color(0xFF8B97A2),
                    //   fontWeight: FontWeight.w500,
                    // ),
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
