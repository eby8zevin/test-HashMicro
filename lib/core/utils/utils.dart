import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
   Future<bool> checkLocationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      PermissionStatus newStatus = await Permission.location.request();
      if (newStatus.isGranted) {
        return true;
      } else if (newStatus.isPermanentlyDenied) {
        _showGoToSettingsDialog(context);
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      _showGoToSettingsDialog(context);
      return false;
    }

    return false;
  }

  void _showGoToSettingsDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Izin Lokasi Diperlukan'),
          content: const Text(
              'Aplikasi ini memerlukan akses lokasi untuk berfungsi dengan baik. Silakan izinkan akses lokasi di pengaturan.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Get.back(); 
                await openAppSettings();
              },
              child: const Text('Pengaturan'),
            ),
          ],
        );
      },
    );
  }
}