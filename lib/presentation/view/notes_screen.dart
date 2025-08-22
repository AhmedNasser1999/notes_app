import 'package:flutter/material.dart';
import 'package:notes_app/presentation/view/create_note.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'My Notes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded( 
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  title: Text("Note $index"),
                  subtitle: Text("This is the content of note $index"),
                  leading: Icon(Icons.note),
                ),
                separatorBuilder: (context,index) => const SizedBox(height: 20.0),
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  CreateNote()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
