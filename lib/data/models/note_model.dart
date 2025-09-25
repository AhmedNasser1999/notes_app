import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class NoteModel extends NoteEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String content;

  @HiveField(3)
  @override
  final String createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  }) : super(title: title, content: content, createdAt: createdAt, id: id);

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
