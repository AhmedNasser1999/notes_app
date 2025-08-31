import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String noteContent;
  // final String createdAt;
  const NoteWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.noteContent,
    // required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context)
                    .colorScheme
                    .surface // No opacity in dark theme
              : Theme.of(
                  context,
                ).colorScheme.surface, // Keep opacity in light theme
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              noteContent,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 20.0),
            ),
            // Text(
            //   createdAt,
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //         fontSize: 15.0,
            //       ),
            // ),
          ],
        ),
      ),
    );
  }
}
