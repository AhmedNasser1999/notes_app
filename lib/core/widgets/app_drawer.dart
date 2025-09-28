import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback changeTheme;
  final VoidCallback deleteAllNotes;
  const AppDrawer({
    super.key,
    required this.changeTheme,
    required this.deleteAllNotes,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NoteCubit>(context);
    final theme = Theme.of(context);
    
    return SafeArea(
      child: Drawer(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Settings',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            _buildAnimatedListTile(
              context: context,
              icon: Icons.delete,
              title: 'Delete all Notes',
              onTap: deleteAllNotes,
              delay: 100,
            ),
            _buildAnimatedListTile(
              context: context,
              icon: cubit.isDark ? Icons.light_mode : Icons.dark_mode,
              title: cubit.isDark ? 'Light theme' : 'Dark theme',
              onTap: changeTheme,
              delay: 200,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAnimatedListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + delay),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.transparent,
        hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
    );
  }
}
