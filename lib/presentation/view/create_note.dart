import 'package:flutter/material.dart';

class CreateNote extends StatelessWidget {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  CreateNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: titleController,
                style: TextStyle(fontSize: 25.0),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 25.0, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(),
              ),
              Expanded(
                child: TextFormField(
                  controller: noteController,
                  style: TextStyle(fontSize: 25.0),
                  minLines: 1,
                  maxLines: 50,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Start typing',
                    hintStyle: TextStyle(fontSize: 25.0, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
