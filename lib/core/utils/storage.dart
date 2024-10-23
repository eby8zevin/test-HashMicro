import 'package:get_storage/get_storage.dart';

import '../../app/data/models/location.model.dart';

class Storage {

  final GetStorage _storage = GetStorage();

  void saveCheckIn(bool checkIn) => _storage.write('checkIn', checkIn);
  void saveCheckOut(bool checkOut) => _storage.write('checkOut', checkOut);

  bool isCheckIn() => _storage.read<bool>('checkIn') ?? false;
  bool isCheckOut() => _storage.read<bool>('checkOut') ?? false;

  void saveSampleData(bool sampleData) => _storage.write('sampleData', sampleData);
  bool getSampleData() => _storage.read<bool>('sampleData') ?? false;

  void saveLocationList(List<LocationModel> locationList) {
    List<Map<String, dynamic>> jsonList = locationList.map((location) => location.toJson()).toList();
    
    _storage.write('locationList', jsonList);
  } 

  void saveLocationToList(LocationModel location) {
    List<dynamic>? locationListJson = _storage.read<List<dynamic>>('locationList');

    List<Map<String, dynamic>> locationList = [];

    if (locationListJson != null) {
      locationList = locationListJson.cast<Map<String, dynamic>>();
    }

    locationList.add(location.toJson());

    _storage.write('locationList', locationList);
  }

  List<LocationModel> getLocationList() {
    var jsonList = _storage.read<List<dynamic>>('locationList');

    if (jsonList != null) {
      return jsonList.map((json) => LocationModel.fromJson(json)).toList();
    }
    
    return [];
  }
}