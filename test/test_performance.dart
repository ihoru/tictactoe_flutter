import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/main.dart';

void main() {
  testWidgets('TicTacToe app performance test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TicTacToeApp());

    // Verify that the app builds without errors
    expect(find.text('TicTacToe Duel'), findsOneWidget);

    // Test game interactions to ensure no performance issues
    // Find the game canvas area (there are multiple CustomPaint widgets)
    final canvasFinder = find.byType(CustomPaint);
    expect(canvasFinder, findsWidgets);

    // Find the main game canvas (should be the largest one)
    final gameCanvas = canvasFinder.first;

    // Simulate multiple taps to test paint performance
    for (int i = 0; i < 3; i++) {
      await tester.tap(gameCanvas);
      await tester.pump();
    }

    // Test restart button
    final restartButton = find.text('RESTART');
    expect(restartButton, findsNWidgets(2)); // Two restart buttons (normal and upside down)

    await tester.tap(restartButton.first);
    await tester.pump();

    // Verify the game restarted successfully (there are 2 status texts - normal and upside down)
    expect(find.textContaining('"X" turn'), findsNWidgets(2));
  });
}
