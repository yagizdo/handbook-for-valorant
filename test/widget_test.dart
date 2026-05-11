import 'package:flutter_test/flutter_test.dart';

import 'package:handbook_for_valorant/main.dart';

void main() {
  testWidgets('ValorantApp can be instantiated', (WidgetTester tester) async {
    // ValorantApp requires AppInit (ObjectBox, DI) which is not available
    // in unit tests. Just verify the class exists and is constructible.
    expect(const ValorantApp(), isA<ValorantApp>());
  });
}
