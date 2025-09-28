import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/note_widget.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';
import 'package:notes_app/presentation/view_model/note_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NoteEntity> _filteredNotes = [];
  List<NoteEntity> _allNotes = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadNotes() {
    final state = context.read<NoteCubit>().state;
    if (state is NoteSuccess) {
      setState(() {
        _allNotes = state.notes;
        _filteredNotes = state.notes;
      });
    }
  }

  void _filterNotes(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredNotes = _allNotes;
      } else {
        _filteredNotes = _allNotes
            .where((note) =>
                note.title.toLowerCase().contains(query.toLowerCase()) ||
                note.content.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterNotes,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search by title or content...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterNotes('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredNotes.isEmpty
                ? Center(
                    child: _isSearching
                        ? Text(
                            'No notes found',
                            style: theme.textTheme.headlineSmall,
                          )
                        : Text(
                            'Start searching your notes',
                            style: theme.textTheme.headlineSmall,
                          ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredNotes.length,
                    itemBuilder: (context, index) {
                      return NoteWidget(
                        onTap: () {
                          context.read<NoteCubit>().modifyNote(
                                _filteredNotes[index].id,
                                context,
                              );
                        },
                        onDelete: () {
                          context.read<NoteCubit>().deleteNoteById(_filteredNotes[index].id);
                          setState(() {
                            _filteredNotes.removeAt(index);
                          });
                        },
                        title: _filteredNotes[index].title,
                        noteContent: _filteredNotes[index].content,
                        categories: _filteredNotes[index].categories,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}