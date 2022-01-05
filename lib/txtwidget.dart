import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  TextWidget({Key? key, required this.txt}) : super(key: key);
  String? txt;
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "${widget.txt}",
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black),
      ),
    );
  }
}
