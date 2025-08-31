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
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete all Notes'),
              onTap: deleteAllNotes,
            ),
            ListTile(
              leading:cubit.isDark? Icon(Icons.light_mode):Icon(Icons.dark_mode),
              title:cubit.isDark?  Text('Light theme'):Text('Dark theme'),
              onTap: changeTheme,
            ),
          ],
        ),
      ),
    );
  }
}
