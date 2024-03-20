import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/providers/todo_provider.dart';

void main() {
  late ProviderContainer container;
  late TodoListNotifier notifier;
  setUp(() {
    container = ProviderContainer();
    notifier = container.read(todoProvider.notifier);
  });
  test('todo list starts empy test', () {
    expect(notifier.state, []);
  });

  test('add todo', () {
    notifier.addTodo("Run Testing");
    expect(notifier.state[0].content, 'Run Testing');
  });

  test('delete todo', () {
    notifier.addTodo("Run Testing");
    expect(notifier.state[0].content, 'Run Testing');

    notifier.deleteTodo(0);
    expect(notifier.state, []);
  });

  test('complete todo', () {
    notifier.addTodo("Run Testing");
    expect(notifier.state[0].content, 'Run Testing');
    expect(notifier.state[0].completed, false);

    notifier.completTodo(0);
    expect(notifier.state[0].completed, true);
  });
}
