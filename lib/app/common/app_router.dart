import 'package:go_router/go_router.dart';
import 'package:vma/app/screens/camera/widgets/live_video.dart';
import 'package:vma/app/screens/medicine_requests/screen.dart';
import 'package:vma/app/screens/pig_detail/screen.dart';
import 'package:vma/app/screens/pig_list/screen.dart';
import 'package:vma/app/screens/vaccination_plan_details/screen.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
import 'package:vma/core/network/app_storage.dart';
import 'package:vma/app/screens/auth/login.dart';
import 'package:vma/app/screens/management/alert.dart';
import 'package:vma/app/screens/management/camera.dart';
import 'package:vma/app/screens/management/home.dart';
import 'package:vma/app/screens/layout.dart';
import 'package:vma/app/screens/management/treatment_plan.dart';
import 'package:vma/app/screens/management/vaccination.dart';

class AppRouter {
  static final _router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const LayoutPage(),
      ),
      GoRoute(
        path: Routes.dashboard,
        builder: (context, state) => const MyHomePage(title: 'Home Screen'),
      ),
      GoRoute(
        path: Routes.vaccination,
        builder: (context, state) {
          return const Vaccination();
        },
      ),
      GoRoute(
        path: Routes.treatment,
        builder: (context, state) => const TreatmentPlan(),
      ),
      GoRoute(
        path: Routes.camera,
        builder: (context, state) => const Camera(),
      ),
      GoRoute(
        path: Routes.alert,
        builder: (context, state) => const Alert(),
      ),
      GoRoute(
        path: Routes.pigDetail,
        builder: (context, state) {
          final id = state.extra as String;
          return PigDetail(pigId: id);
        },
      ),
      GoRoute(
        path: Routes.vaccinationPlanDetails,
        builder: (context, state) {
          final id = state.extra as String;
          return VaccinationPlanDetailsScreen(planId: id);
        },
      ),
      GoRoute(
        path: Routes.liveVideo,
        builder: (context, state) {
          final id = state.extra as String;
          return LiveVideo(cameraId: id);
        },
      ),
      GoRoute(
        path: Routes.pigList,
        builder: (context, state) => const PigList(),
      ),
      GoRoute(
        path: Routes.medicineRequests,
        builder: (context, state) => const MedicineRequestsScreen(),
      ),
    ],
    redirect: (context, state) async {
      String? token = await AppStorage.read(AppStorageKeys.token);
      if (token == null || token.isEmpty) {
        return Routes.login;
      } else {
        return Routes.home;
      }
    },
  );

  static GoRouter get router => _router;
}
