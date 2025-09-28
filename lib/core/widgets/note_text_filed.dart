import 'package:flutter/material.dart';

class NoteTextFiled extends StatelessWidget {
  final TextEditingController controller;
  const NoteTextFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: TextFormField(
        controller: controller,
        style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18.0, height: 1.5),
        minLines: 1,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: 'Start typing...',
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 18.0,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          isDense: true, // Reduces the vertical padding
        ),
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}
