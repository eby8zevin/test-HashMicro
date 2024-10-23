import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../core/utils/storage.dart';
import '../data/models/location.model.dart';

class AllBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AllController>(AllController());
  }
} 

class AllController extends GetxController {

  final Storage storage = Storage();
  RxList<LocationModel> listLocationModel = <LocationModel>[].obs;
  final dateNow = DateTime.now();
  RxString schedule = ''.obs;
  RxBool sampleData = false.obs;

  @override
  void onInit() {
    schedule.value = DateFormat('dd MMM yyyy', 'id').format(dateNow);
    sampleData.value = storage.getSampleData();
    if (!sampleData.value) {
      storage.saveLocationList(sampleLocations);
      storage.saveSampleData(true);
    } 
    super.onInit();
    listLocationModel.value = storage.getLocationList();
    loadMarkersFromStorage();
  }

  List<LocationModel> sampleLocations = [
    LocationModel(name: "Kantor Pusat", latitude: -6.170712270736742, longitude: 106.81335623395857, radius: 50),
    LocationModel(name: "Kantor Cabang", latitude: -7.288764699385314, longitude: 112.67785758470717, radius: 100),
  ];

  //Geo-tagging
  Completer<GoogleMapController> mapController = Completer();
  Rx<LatLng> initialPosition = const LatLng(-6.170712270736742, 106.81335623395857).obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  LocationModel? selectedLocation;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();

  void loadMarkersFromStorage() {
    for (var location in listLocationModel) {
      markers.add(
        Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: 'Radius: ${location.radius} meter',
          ),
        ),
      );
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  void addMarker(LatLng position) {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: const InfoWindow(
            title: 'Selected Location',
          ),
        ),
      );
      selectedLocation = LocationModel(
        name: 'Selected Location',
        latitude: position.latitude,
        longitude: position.longitude,
        radius: 100,
      );
  }

  void saveLocationData(String name, int radius) {
    LocationModel saveLocation = LocationModel(
      name: name,
      latitude: selectedLocation!.latitude,
      longitude: selectedLocation!.longitude,
      radius: radius,
    );

    storage.saveLocationToList(saveLocation);
    listLocationModel.value = storage.getLocationList();
    loadMarkersFromStorage();
  }

  //Attendance
  RxString textInOut = ''.obs;
  Future<void> checkInOrOut(LocationModel location, String absen) async {
    EasyLoading.show();
    Position userPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double distanceInMeters = Geolocator.distanceBetween(
      location.latitude,
      location.longitude,
      userPosition.latitude,
      userPosition.longitude,
    );

    if (distanceInMeters <= location.radius) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('$absen berhasil!');
      Get.back();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('$absen gagal / diluar radius!');
    }
  }

}