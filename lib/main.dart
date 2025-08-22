import 'package:flutter/material.dart';
import 'package:notes_app/core/config/di.dart';
import 'package:notes_app/presentation/view/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: NotesScreen(),
    );
  }
}
