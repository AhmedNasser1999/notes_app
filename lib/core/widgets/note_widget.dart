import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:notes_app/core/widgets/categories_widget.dart';

class NoteWidget extends StatelessWidget {
  final String title;
  final String noteContent;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final List<String> categories;

  const NoteWidget({
    super.key,
    required this.title,
    required this.noteContent,
    required this.onTap,
    this.onDelete,
    this.categories = const [],
  });
  
  void shareNote(String text) {
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    // Create a subtle accent color for the card border
    final accentColor = isDark 
        ? HSLColor.fromColor(colorScheme.primary).withLightness(0.3).toColor()
        : HSLColor.fromColor(colorScheme.primary).withLightness(0.85).toColor();
    
    return Hero(
      tag: 'note_${title.hashCode}_${noteContent.hashCode}',
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: isDark 
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: accentColor,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty) ...[                  
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Divider(
                    color: accentColor.withOpacity(0.5),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 12.0),
                ],
                Text(
                  noteContent,
                  maxLines: title.isNotEmpty ? 3 : 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: title.isNotEmpty ? 16.0 : 18.0,
                    fontWeight: title.isEmpty ? FontWeight.w500 : FontWeight.normal,
                    height: 1.4,
                  ),
                ),
                if (categories.isNotEmpty) ...[
                  const SizedBox(height: 12.0),
                  CategoriesWidget(categories: categories),
                ],
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onDelete != null)
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 18,
                          color: Colors.red.withOpacity(0.7),
                        ),
                        onPressed: onDelete,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    if (onDelete != null)
                      const SizedBox(width: 12),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        size: 18,
                        color: colorScheme.primary.withOpacity(0.7),
                      ),
                      onPressed: () {
                        final shareText = title.isNotEmpty 
                            ? '$title\n\n$noteContent' 
                            : noteContent;
                        shareNote(shareText);
                      },
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: colorScheme.primary.withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
