import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/completed.dart';
import 'package:todo/providers/todo_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos
        .where(
          (todo) => todo.completed == false,
        )
        .toList();
    List<Todo> completedTodos = todos
        .where(
          (todo) => todo.completed == true,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO App'),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (activeTodos.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 300),
              child: Center(
                child: Text('Add a todo using the button below'),
              ),
            );
          } else if (index == activeTodos.length) {
            if (completedTodos.isEmpty) {
              return Container();
            } else {
              return Center(
                child: TextButton(
                  child: const Text('Completed Todos'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CompletedTodo()),
                    );
                  },
                ),
              );
            }
          } else {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .deleteTodo(activeTodos[index].todoID),
                    icon: Icons.delete,
                  )
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .completTodo(activeTodos[index].todoID),
                    icon: Icons.check,
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
                child: ListTile(
                  title: Text(todos[index].content),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTodo()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
