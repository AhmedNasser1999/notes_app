import 'package:flutter/material.dart';

class TitleTextFiled extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
      ),
    );
  }
}