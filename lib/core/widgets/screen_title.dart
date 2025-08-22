import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Notes',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
