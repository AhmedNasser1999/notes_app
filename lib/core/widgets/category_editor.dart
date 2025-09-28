import 'package:flutter/material.dart';

class CategoryEditor extends StatefulWidget {
  final List<String> initialCategories;
  final Function(List<String>) onCategoriesChanged;

  const CategoryEditor({
    super.key,
    this.initialCategories = const [],
    required this.onCategoriesChanged,
  });

  @override
  State<CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends State<CategoryEditor> {
  late List<String> _categories;
  final TextEditingController _categoryController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _categories = List.from(widget.initialCategories);
  }
  
  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  void _addCategory(String category) {
    if (category.trim().isEmpty) return;
    
    setState(() {
      if (!_categories.contains(category.trim())) {
        _categories.add(category.trim());
        widget.onCategoriesChanged(_categories);
      }
    });
    _categoryController.clear();
  }

  void _removeCategory(String category) {
    setState(() {
      _categories.remove(category);
      widget.onCategoriesChanged(_categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  hintText: 'Add a category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onSubmitted: _addCategory,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addCategory(_categoryController.text),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((category) {
            return Chip(
              label: Text('#$category'),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () => _removeCategory(category),
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              side: BorderSide(
                color: theme.colorScheme.primary.withOpacity(0.3),
              ),
              labelStyle: TextStyle(
                color: theme.colorScheme.primary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}