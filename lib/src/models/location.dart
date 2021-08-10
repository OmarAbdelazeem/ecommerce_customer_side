class Location {
  String country;

  String administrativeArea;

  String subAdministrativeArea;

  String locality;
  double latitude;
  double longitude;

  Location({
    required this.country,
    required this.administrativeArea,
    required this.subAdministrativeArea,
    required this.latitude,
    required this.longitude,
    required this.locality,
  });
}
