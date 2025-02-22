import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/main.dart';

void main() {
  testWidgets('Calculator UI elements should be present', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('*'), findsOneWidget);
    expect(find.text('/'), findsOneWidget);
    expect(find.text('='), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('Calculator should perform addition', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('2'));
    await tester.pump();

    await tester.tap(find.text('+'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('5.0'), findsOneWidget);
  });

  testWidgets('Calculator should perform subtraction', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('8'));
    await tester.pump();

    await tester.tap(find.text('-'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('5.0'), findsOneWidget);
  });

  testWidgets('Calculator should perform multiplication', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('6'));
    await tester.pump();

    await tester.tap(find.text('*'));
    await tester.pump();

    await tester.tap(find.text('4'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('24.0'), findsOneWidget);
  });

  testWidgets('Calculator should perform division', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('9'));
    await tester.pump();

    await tester.tap(find.text('/'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('3.0'), findsOneWidget);
  });

  testWidgets('Calculator should clear display when C is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('7'));
    await tester.pump();

    await tester.tap(find.text('C'));
    await tester.pump();

    expect(find.byWidgetPredicate((widget) =>
  widget is Text && widget.data == '0' && widget.style?.fontSize == 48.0
), findsOneWidget);


  });
}
