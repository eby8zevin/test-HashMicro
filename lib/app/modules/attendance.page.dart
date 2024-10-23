import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/app/modules/all.controller.dart';

class AttendancePage extends GetView<AllController> {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance ${controller.textInOut.value}'),
      ),
      body: ListView.builder(
        itemCount: controller.listLocationModel.length,
        itemBuilder: (context, index) {
          final location = controller.listLocationModel[index];
          return ListTile(
            title: Text(location.name),
            subtitle: Text('Radius: ${location.radius} meters'),
            trailing: ElevatedButton(
              onPressed: () {
                controller.checkInOrOut(location, controller.textInOut.value);
              },
              child: const Text('Absen'),
            ),
          );
        },
      ),
    );
  }
}
