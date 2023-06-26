import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final text;
  final color;
  final double? fontSize;
  final fontFamily;
  final fontWeight;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final TextOverflow textOverflow;



  const TextView({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
    this.textOverflow = TextOverflow.fade,
  }) : super(key: key);

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        decoration: widget.decoration,
        color: widget.color,
        fontSize: widget.fontSize,
        fontFamily: widget.fontFamily,
        fontWeight: widget.fontWeight,
      ),
      overflow: widget.textOverflow,
      textAlign: widget.textAlign,
    );
  }
}
