
import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';
import '../Utils/text_view.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.litegreen,
        appBar: AppBar(
          backgroundColor: AppColors.appgreen,
            title: TextView(text: "Chart Screen",color: AppColors.white,)
        ),
        body: Container(
          child:Column(
            children: [
              SizedBox(height: 300,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: TextView(text: "Chart Screen",fontSize: 30,color: AppColors.appgreen)
                ),
              ),
            ],
          ),
        )
    );
  }
}
