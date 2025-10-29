import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_lerning_flutter/models/todo.dart';

final todoList = StateNotifierProvider<TodoListProvider, List<Todo>>(
  (ref) => TodoListProvider(),
);

class TodoListProvider extends StateNotifier<List<Todo>> {
  TodoListProvider() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(Todo todo) {
    state = state.where((t) => t.id != todo.id).toList();
  }

  void updateTodo(String id, {String? newTitle, bool? newCompletedValue}) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
          title: newTitle ?? todo.title,
          completed: newCompletedValue ?? todo.completed,
        );
      }
      return todo;
    }).toList();
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();
  }
}
