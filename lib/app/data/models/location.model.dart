class LocationModel {
  final String name;
  final double latitude;
  final double longitude;
  final int radius;

  LocationModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
    );
  }
}