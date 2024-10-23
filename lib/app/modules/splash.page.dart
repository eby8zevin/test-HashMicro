import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/core/utils/utils.dart';
import 'package:mobile_attendance/routes/pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

   @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Utils utiils = Utils();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if(await utiils.checkLocationPermission(Get.context!)) {
        Get.offAllNamed(Routes.dashboard);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: 100.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Mobile Attendance',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.0),
            SpinKitWave(
              color: Colors.lightBlue,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}