
import 'package:flutter/material.dart';

import '../Utils/text_view.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: TextView(text: "Rating Screen",)
        ),
        body: Container(
          child:Column(
            children: [
              SizedBox(height: 300,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: TextView(text: "Rating Screen",fontSize: 30,color: Colors.greenAccent,)
                ),
              ),
            ],
          ),
        )
    );
  }
}
