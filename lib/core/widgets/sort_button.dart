import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/config/sort_options.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final noteCubit = context.read<NoteCubit>();
    
    return PopupMenuButton<SortOption>(
      icon: Icon(
        Icons.sort,
        color: theme.colorScheme.primary,
      ),
      tooltip: 'Sort notes',
      onSelected: (SortOption option) {
        noteCubit.sortNotes(option);
      },
      itemBuilder: (context) => SortOption.values.map((option) {
        return PopupMenuItem<SortOption>(
          value: option,
          child: Row(
            children: [
              Icon(
                _getIconForOption(option),
                color: noteCubit.currentSortOption == option
                    ? theme.colorScheme.primary
                    : null,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                option.label,
                style: TextStyle(
                  fontWeight: noteCubit.currentSortOption == option
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: noteCubit.currentSortOption == option
                      ? theme.colorScheme.primary
                      : null,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getIconForOption(SortOption option) {
    switch (option) {
      case SortOption.dateNewest:
        return Icons.arrow_downward;
      case SortOption.dateOldest:
        return Icons.arrow_upward;
      case SortOption.titleAZ:
        return Icons.sort_by_alpha;
      case SortOption.titleZA:
        return Icons.sort_by_alpha_outlined;
    }
  }
}