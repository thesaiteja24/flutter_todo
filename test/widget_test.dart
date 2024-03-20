import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/main.dart';

void main() {
  testWidgets("default state", (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    Finder defaultText = find.text("Add a todo using the button below");
    expect(defaultText, findsOneWidget);
  });
}
