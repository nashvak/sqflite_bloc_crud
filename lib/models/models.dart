import 'dart:typed_data';

class Todo {
  final int? id;
  final String title;
  final String description;
  final Uint8List imageBytes;

  Todo(
      {required this.title,
      required this.description,
      this.id,
      required this.imageBytes});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageBytes': imageBytes,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      description: map['description'],
      id: map['id'],
      title: map['title'],
      imageBytes: map['imageBytes'],
    );
  }
}
