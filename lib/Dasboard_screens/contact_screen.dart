import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/text_view.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.litegreen,
        appBar: AppBar(
          backgroundColor: AppColors.appgreen,
            title: TextView(text: "Contact Screen",)
        ),
        body: Container(
          child:Column(
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: TextView(text: " Name : Mahad",fontSize: 30,color: AppColors.appgreen,)
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: TextView(text: " Phone : +923134187877",fontSize: 30,color:AppColors.appgreen,)
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: TextView(text: "Gmail: mahadchaudary155@gmail.com",fontSize: 30,color: AppColors.appgreen)
                ),
              ),
            ],
          ),
        )
    );
  }
}
