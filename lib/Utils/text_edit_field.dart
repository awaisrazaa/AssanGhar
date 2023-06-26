import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextEditField extends StatefulWidget {
  final String hintText;
  final errorText;
  final  maxLength;
  final String labelText;
  final double hintSize;
  final double radius;
  final bool isPassword;
  final Color hintcolor;
  final Color textColor;
  final Color cursorColor;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final preffixIcon;
  final double width;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final onChanged;
  final onTap;
  final maxlength;

  const TextEditField({
    Key? key,
    required this.hintText,
    this.errorText,
    required this.textEditingController,
    this.labelText = "",
    this.isPassword = false,
    this.hintSize = 18,
    this.radius = 0,
    this.hintcolor = Colors.black38,
    this.textColor = Colors.black,
    this.cursorColor = Colors.blue,
    this.inputType = TextInputType.text,
    this.preffixIcon,
    required this.width,
    this.onChanged,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false, this.maxlength, this.maxLength,
  }) : super(key: key);

  @override
  State<TextEditField> createState() => _TextInputFieldViewState();
}

class _TextInputFieldViewState extends State<TextEditField> {
  bool isObscure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.isPassword == true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextFormField(
        maxLength: widget.maxLength,
        onTap: widget.onTap,
        obscureText: isObscure,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        style: TextStyle(color: widget.textColor, fontSize: widget.hintSize),
        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          errorText: widget.errorText,
          errorStyle: TextStyle(fontSize: widget.hintSize, color: Colors.red),
          hintStyle:
              TextStyle(fontSize: widget.hintSize, color: widget.hintcolor),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.greenAccent)),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : SizedBox(),
          prefixIcon: widget.preffixIcon,
        ),
        textCapitalization: widget.textCapitalization,
        cursorColor: widget.cursorColor,
        cursorWidth: 1.5,
      ),
    );
  }
}
