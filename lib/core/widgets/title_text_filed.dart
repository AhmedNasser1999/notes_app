import 'package:flutter/material.dart';

class TitleTextFiled extends StatelessWidget {
  final TextEditingController controller;
  const TitleTextFiled({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 25.0),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(fontSize: 25.0, color: Colors.grey),
      ),
    );
  }
}
