import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GamePage Tests', () {
    testWidgets('GamePage renders correctly', (WidgetTester tester) async {
      // TODO: GamePage をテスト
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
