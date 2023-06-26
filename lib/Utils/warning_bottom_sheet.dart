import 'package:flutter/material.dart';
import 'package:onboard_animation/Utils/text_view.dart';
import 'app_colors.dart';
import 'dimensions.dart';

class WarningBottomSheet extends StatefulWidget {
  final onOkPressed;
  final onCancelPressed;
  final Function onDispose;
  final String msg;
  final String ok;
  final String cancel;

  WarningBottomSheet({
    Key? key,
    required this.onOkPressed,
    required this.onCancelPressed,
    required this.onDispose,
    this.msg = "Do you really want to delete this item?",
    this.ok = "Delete",
    this.cancel = "Cancel",
  }) : super(key: key);

  @override
  State<WarningBottomSheet> createState() => _WarningBottomSheetState();
}

class _WarningBottomSheetState extends State<WarningBottomSheet> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenWidth(context) / 2,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextView(text: widget.msg),
          Row(
            children: [
              // AddressBTN(
              //   width: Dimensions.screenWidth(  context) / 2,
              //   title: widget.cancel,
              //   textColor: AppColors.white,
              //   color: AppColors.mainColor,
              //   onPressed: widget.onCancelPressed,
              //   //     () {
              //   //   rHVM.getHistory();
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // AddressBTN(
              //   width: Dimensions.screenWidth(  context) / 2,
              //   title: widget.ok,
              //   textColor: AppColors.white,
              //   color: AppColors.red,
              //   onPressed: widget.onOkPressed,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
