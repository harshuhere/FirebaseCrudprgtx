import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  EditText(
      {Key? key,
      this.edttxtlable,
      this.errorString,
      this.txtedtcntroller,
      this.txtinputtype,
      this.length})
      : super(key: key);

  TextEditingController? txtedtcntroller;
  String? errorString;
  String? edttxtlable;
  TextInputType? txtinputtype;
  int? length;

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: TextFormField(
            controller: widget.txtedtcntroller,
            keyboardType: widget.txtinputtype,
            maxLength: widget.length,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '${widget.errorString}';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "${widget.edttxtlable}"),
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
