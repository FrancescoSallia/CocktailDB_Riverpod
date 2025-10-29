import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/models/todo.dart';
import 'package:riverpod_lerning_flutter/providers/todo_list_provider.dart';

class DetailScreen extends ConsumerWidget {
  final Todo todo;
  const DetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final notifier = ref.read(todoList.notifier);
    final currentTodo = ref.watch(todoList).firstWhere((t) => t.id == todo.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Detail"),
        centerTitle: true,
        actions: [
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: Colors.red.withValues(alpha: 0.1),
            ),
            onPressed: () {
              Navigator.pop(context);
              notifier.removeTodo(todo);
            },
            icon: Icon(Icons.delete, color: Colors.red, size: 20),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Todo Id: ${todo.id}"),
            Text("Todo Title: ${currentTodo.title}"),
            Text(
              todo.completed
                  ? "Todo Completed?: Yes (${currentTodo.completed})"
                  : "Todo Completed?: No (${currentTodo.completed})",
            ),

            SizedBox(height: 70),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: "change Title hier"),
              ),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Completed?",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Checkbox(
                  value: currentTodo.completed,
                  onChanged: (value) {
                    notifier.toggleTodo(currentTodo.id);
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            ValueListenableBuilder(
              valueListenable: titleController,
              builder: (context, value, child) {
                return TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: value.text.isNotEmpty
                        ? Colors.black
                        : Colors.black.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(6),
                    ),
                  ),
                  onPressed: titleController.text.isNotEmpty
                      ? () {
                          if (value.text.isEmpty) return;
                          final Todo updatedTodo = Todo(
                            id: todo.id,
                            title: titleController.text,
                            completed: todo.completed,
                          );
                          notifier.updateTodo(
                            updatedTodo.id,
                            newTitle: updatedTodo.title,
                            newCompletedValue: updatedTodo.completed,
                          );
                        }
                      : null,
                  child: Text("Update", style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
