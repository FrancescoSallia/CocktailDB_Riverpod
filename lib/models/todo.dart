import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final bool completed;

  Todo({String? id, required this.title, this.completed = false})
    : id = id ?? Uuid().v4();

  Todo copyWith({String? title, bool? completed}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
