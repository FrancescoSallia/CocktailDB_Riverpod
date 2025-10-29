import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lerning_flutter/models/todo.dart';
import 'package:riverpod_lerning_flutter/providers/todo_list_provider.dart';
import 'package:riverpod_lerning_flutter/screens/detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final todos = ref.watch(todoList);
    final todoNotifier = ref.read(todoList.notifier);
    return Scaffold(
      appBar: AppBar(title: Text("Riverpod Lerning App"), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(child: Text("Hier werden alle Todo unten aufgelistet")),
          SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(todo: todo),
                    ),
                  ),
                  onLongPress: () => todoNotifier.removeTodo(todo),
                  title: Text(todo.title),
                  subtitle: Text(todo.id),
                  trailing: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      todoNotifier.toggleTodo(todo.id);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Todo"),
              content: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "e.g. Cleanning, build apps ...",
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.clear();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.text.isEmpty) return;
                    final newTodo = Todo(title: controller.text);
                    todoNotifier.addTodo(newTodo);
                    Navigator.pop(context);
                    controller.clear();
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
