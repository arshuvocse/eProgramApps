// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart';
import 'package:myapp/router.dart';
import 'package:myapp/views/login_view.dart';

void main() {
  testWidgets('Renders LoginView initially', (WidgetTester tester) async {
    // Create dependencies
    final appRouter = AppRouter();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      appRouter: appRouter,
    ));
    await tester.pumpAndSettle(); // Allow router to settle

    // Verify that LoginView is shown initially.
    expect(find.byType(LoginView), findsOneWidget);
  });
}
