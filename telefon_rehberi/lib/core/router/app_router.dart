import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: ContactsRoute.page, initial: true),
    AutoRoute(page: AddContactRoute.page),
    CustomRoute(
      page: SuccessAnimationRoute.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      duration: Duration.zero,
    ),
  ];
}
