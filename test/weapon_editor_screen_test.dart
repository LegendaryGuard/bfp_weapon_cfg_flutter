import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bfp_weapon_cfg_flutter/main.dart';

void main() {
  testWidgets('Startup shows load prompt', (WidgetTester tester) async {
    // pump the app
    await tester.pumpWidget(const WeaponEditorApp());

    // wait for frames
    await tester.pumpAndSettle();

    // expect the load prompt text
    expect(
      find.text('Load bfp_weapon.cfg or bfp_weapon2.cfg to edit'),
      findsOneWidget,
    );

    // expect the Add button is hidden (no weapons loaded)
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
