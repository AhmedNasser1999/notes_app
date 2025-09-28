class NoteEntity {
  final String id;
  final String title;
  final String content;
  final String createdAt;
  final List<String> categories;

  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.categories = const [],
  });
}
