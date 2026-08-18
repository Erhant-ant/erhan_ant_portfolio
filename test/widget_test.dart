import 'package:erhan_ant_portfolio_v2/main.dart';
import 'package:erhan_ant_portfolio_v2/core/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Portfolio app opens on the home screen', (tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('Erhan Ant'), findsOneWidget);
    expect(find.text('Technology & Software'), findsOneWidget);
  });

  testWidgets('Portfolio opens a shared project route', (tester) async {
    tester.binding.platformDispatcher.defaultRouteNameTestValue =
        AppRoutes.projects;
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );

    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('Projects'), findsWidgets);
    expect(find.text('SupportDesk'), findsOneWidget);
  });
}
