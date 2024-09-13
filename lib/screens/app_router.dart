import 'package:go_router/go_router.dart';
import 'package:vma/constants/route_constant.dart';
import 'package:vma/network/app_storage.dart';
import 'package:vma/screens/auth/login.dart';
import 'package:vma/screens/management/alert.dart';
import 'package:vma/screens/management/camera.dart';
import 'package:vma/screens/management/foo_screen.dart';
import 'package:vma/screens/management/home.dart';
import 'package:vma/screens/layout.dart';
import 'package:vma/screens/management/treatment_plan.dart';
import 'package:vma/screens/management/vaccination.dart';

class AppRouter {
  static final _router = GoRouter(
    initialLocation: RouteConstant.home,
    routes: [
      GoRoute(
        path: RouteConstant.login,
        builder: (context, state) => const Login(),
      ),
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
    ],
    redirect: (context, state) async {
      String token = await AppStorage().read("token");
      if (token.isEmpty) {
        return RouteConstant.login;
      } else {
        return RouteConstant.home;
      }
    },
  );

  static GoRouter get router => _router;
}
