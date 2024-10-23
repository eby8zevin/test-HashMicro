import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/app/modules/all.controller.dart';

class GeoTaggingPage extends GetView<AllController> {
  const GeoTaggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo-tagging'),
      ),
      body: Obx(() => GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: controller.onMapCreated,
        initialCameraPosition: CameraPosition(
          target: controller.initialPosition.value,
          zoom: 14.0,
        ),
        // ignore: invalid_use_of_protected_member
        markers: controller.markers.value,
        onTap: (position) {
           controller.addMarker(position);
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.selectedLocation != null) {
            Get.dialog(
              AlertDialog(
                title: const Text('Simpan Lokasi'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(labelText: 'Nama Lokasi'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.radiusController,
                      decoration: const InputDecoration(labelText: 'Radius (meter)'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String name = controller.nameController.text.trim();
                      int? radius = int.tryParse(controller.radiusController.text.trim());

                      if (name.isNotEmpty && radius != null && radius > 0) {
                        controller.saveLocationData(name, radius);

                        Get.back();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Nama dan radius harus diisi dengan benar'),
                        ));
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              )
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
