import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import 'Utils/app_colors.dart';
import 'components/Dashboard.dart';



class ImageGenerationForm extends StatefulWidget {
  String? email;

  ImageGenerationForm({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  _ImageGenerationFormState createState() => _ImageGenerationFormState();
}

class _ImageGenerationFormState extends State<ImageGenerationForm> with SingleTickerProviderStateMixin {
  final String apiToken = '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';
  bool _isLoading = false;
  String? _output;
  final _controller = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
      appBar: AppBar(
        backgroundColor:AppColors.appgreen,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard(email: widget.email)));
          },
        ),
        title: Text('Assan Ghar AI'), // Set the app bar title
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Assan Ghar AI',
                  style: TextStyle(fontSize: 24,color: AppColors.appgreen,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text('Your personal AI, which will suggest you images based on your commands'),
                SizedBox(height: 5,),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type your prompt here...',
                  ),
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: () => _handleSubmit(),
                  style: ElevatedButton.styleFrom(
                    primary:AppColors.appgreen, // Set the button color to light green
                  ),
                  child: Text('Generate'),
                ),
                SizedBox(height: 16),
                _isLoading
                    ? Lottie.asset(
                  'assets/99274-loading.json', // Replace with the actual path to your JSON animation file
                  controller: _animationController,
                )
                    : _output != null
                    ? Image.memory(
                  base64Decode(_output!),
                  fit: BoxFit.fill,
                )
                    : Icon(Icons.image, size: 150, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://api-inference.huggingface.co/models/prompthero/openjourney'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({'inputs': _controller.text}),
    );

    if (response.statusCode == 200) {
      _output = base64Encode(response.bodyBytes);
    } else {
      throw Exception('Failed to generate image');
    }

    setState(() {
      _isLoading = false;
    });
  }
}
