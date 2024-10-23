
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_attendance/app/modules/all.controller.dart';
import 'package:mobile_attendance/routes/pages.dart';

import '../../core/themes/colors.dart';

class DashboardPage extends GetView<AllController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColor.colorPrimary,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      'Live Attendance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        final now = DateTime.now();
                        var formattedTime = DateFormat('HH:mm:ss').format(now);
                        var formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id').format(now);

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 1.0),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.2,
              left: 20.0,
              right: 20.0,
              child: SizedBox(
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Obx(() => Text(
                        'Schedule: ${controller.schedule}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey
                        ),
                      )),
                      const SizedBox(
                        height: 3.0,
                      ),
                      const Text(
                        '08:00 - 17:00',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                  ),
                                  onPressed: () {
                                    controller.textInOut.value = 'Check-In';
                                    Get.toNamed(Routes.attendance);
                                  },
                                  child: const Text(
                                    'Check-In',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                  ),
                                  onPressed: () {
                                    controller.textInOut.value = 'Check-Out';
                                    Get.toNamed(Routes.attendance);
                                  },
                                  child: const Text(
                                    'Check-Out',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.geoTagging);
                          },
                          child: const Text(
                            'Add Geo-tagging',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0
                      ),
                    ],
                  ),
                ),
              )
            )
          ],
        )
      ),
    );
  }
  
}