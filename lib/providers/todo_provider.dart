import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String content) {
    state = [
      ...state,
      Todo(
        todoID: state.isEmpty ? 0 : state[state.length - 1].todoID + 1,
        content: content,
        completed: false,
      )
    ];
  }

  void completTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.todoID == id)
          Todo(completed: true, todoID: todo.todoID, content: todo.content)
        else
          todo
    ];
  }

  void deleteTodo(int id) {
    /* goes throug all the todos and return an iterable of all the todo's
       without the id that we have passed it*/
    state = state.where((todo) => todo.todoID != id).toList();
  }
}
