
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget LoadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.red),
  );
}