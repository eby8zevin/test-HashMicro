import 'package:get/get.dart';
import 'package:mobile_attendance/app/modules/all.controller.dart';
import 'package:mobile_attendance/app/modules/dashboard.page.dart';
import 'package:mobile_attendance/app/modules/geo_tagging.page.dart';

import '../app/modules/attendance.page.dart';
import '../app/modules/splash.page.dart';

part 'routes.dart';

List<GetPage> routes = [
  GetPage(
    name: Routes.splash,
    page: () => const SplashPage(),
  ),
   GetPage(
    name: Routes.dashboard,
    page: () => const DashboardPage(),
    binding: AllBinding(),
  ),
  GetPage(
    name: Routes.geoTagging, 
    page: () => const GeoTaggingPage(),
    binding: AllBinding(),
  ),
  GetPage(
    name: Routes.attendance, 
    page: () => const AttendancePage(),
  ),
];