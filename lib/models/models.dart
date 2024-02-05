class Todo {
  final String id;
  final String title;
  final String description;

  Todo({this.title = '', required this.description, required this.id});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      description: map['description'],
      id: map['id'],
      title: map['title'],
    );
  }
}
