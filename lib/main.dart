import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_attendance/core/themes/colors.dart';
import 'package:mobile_attendance/routes/pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  loadingInstance();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void loadingInstance() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColor.colorPrimary
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColor.colorPrimary
    ..textColor = AppColor.colorPrimary
    ..maskColor = Colors.red.withOpacity(0.5)
    ..userInteractions = true
    ..boxShadow = [
      BoxShadow(
        color: Colors.grey.withOpacity(0.8),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(1, 4),
      )
    ]
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mobile Attendance',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('id', 'ID'), Locale('en', 'US')],
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      initialRoute: Routes.splash,
      getPages: routes,
      builder: EasyLoading.init(),
    );
  }
}