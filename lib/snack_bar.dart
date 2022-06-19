import 'package:flutter/material.dart';

class CustomSnackBar{
  static showSnackBar(context,String content){
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(
          content,
        ),
      ),
    );
  }
}