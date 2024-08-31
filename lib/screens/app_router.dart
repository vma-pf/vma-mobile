import 'package:go_router/go_router.dart';
import 'package:vma/constants/route_constant.dart';
import 'package:vma/screens/foo_screen.dart';
import 'package:vma/screens/home.dart';

class AppRouter {
  static final _router = GoRouter(initialLocation: RouteConstant.home, routes: [
    GoRoute(
      path: RouteConstant.home,
      builder: (context, state) => const MyHomePage(title: 'Hello, World!'),
    ),
    GoRoute(
      path: RouteConstant.register,
      builder: (context, state) => const FooScreen(),
    ),
  ]);

  static GoRouter get router => _router;
}
