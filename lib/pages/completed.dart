import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo_provider.dart';

class CompletedTodo extends ConsumerWidget {
  const CompletedTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);

    List<Todo> completedTodos = todos
        .where(
          (todo) => todo.completed == true,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed TODO'),
      ),
      body: ListView.builder(
        itemCount: completedTodos.length,
        itemBuilder: (context, index) {
          return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .deleteTodo(completedTodos[index].todoID),
                    icon: Icons.delete,
                  )
                ],
              ),
              child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(title: Text(completedTodos[index].content))));
        },
      ),
    );
  }
}
