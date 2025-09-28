import 'package:flutter/material.dart';

class TitleTextFiled extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      style: theme.textTheme.displayLarge?.copyWith(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        hintText: 'Title',
        hintStyle: theme.textTheme.displayLarge?.copyWith(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        isDense: true, // Reduces the vertical padding
      ),
      textCapitalization: TextCapitalization.sentences,
      maxLines: 2,
    );
  }
}
