import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String noteContent;

  const NoteWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.noteContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
            Text(
              noteContent,
              maxLines: title.isNotEmpty ? 2 : null,
              overflow: title.isNotEmpty ? TextOverflow.ellipsis : null,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: title.isNotEmpty ? 20.0 : 18.0,
                fontWeight: title.isEmpty ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
