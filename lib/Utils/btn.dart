import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboard_animation/Utils/text_view.dart';
import 'app_colors.dart';

class BTN extends StatefulWidget {
  final title;
  final splashColor;
  final double? fontSize;
  final double width;
  final color;
  final fontWeight;
  final textColor;
  final fontFamily;
  final onPressed;
  final bool showBorder;

  const BTN({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.width,
    this.splashColor,
    this.showBorder = false,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textColor,
    this.fontFamily,
  }) : super(key: key);

  @override
  State<BTN> createState() => _BTNState();
}

class _BTNState extends State<BTN> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
          border: Border.all(
              color:
                  widget.showBorder ? AppColors.black : AppColors.transparent,
              width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: MaterialButton(
        onPressed: widget.onPressed,
        color: widget.color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          // padding: const EdgeInsets.all(20.0),
          child: TextView(
            text: widget.title,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.textColor,
            fontFamily: widget.fontFamily,
          ),
        ),
        splashColor: widget.splashColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
