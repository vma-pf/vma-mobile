import 'package:go_router/go_router.dart';
import 'package:vma/constants/route_constant.dart';
import 'package:vma/screens/alert.dart';
import 'package:vma/screens/camera.dart';
import 'package:vma/screens/foo_screen.dart';
import 'package:vma/screens/home.dart';
import 'package:vma/screens/layout.dart';
import 'package:vma/screens/treatment_plan.dart';
import 'package:vma/screens/vaccination.dart';

class AppRouter {
  static final _router = GoRouter(initialLocation: RouteConstant.home, routes: [
    GoRoute(
      path: RouteConstant.home,
      builder: (context, state) => const LayoutPage(),
    ),
    GoRoute(
      path: RouteConstant.dashboard,
      builder: (context, state) => const MyHomePage(title: 'Home Screen'),
    ),
    GoRoute(
        path: RouteConstant.vaccination,
        builder: (context, state) {
          return const Vaccination();
        }),
    GoRoute(
      path: RouteConstant.treatment,
      builder: (context, state) => const TreatmentPlan(),
    ),
    GoRoute(
      path: RouteConstant.camera,
      builder: (context, state) => const Camera(),
    ),
    GoRoute(
      path: RouteConstant.alert,
      builder: (context, state) => const Alert(),
    ),
    GoRoute(
      path: RouteConstant.register,
      builder: (context, state) => const FooScreen(),
    ),
  ]);

  static GoRouter get router => _router;
}
