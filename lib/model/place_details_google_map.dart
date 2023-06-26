class PlaceDetailsGoogleMapsModel {
  final double lat;
  final double long;

  const PlaceDetailsGoogleMapsModel({required this.lat, required this.long});

  factory PlaceDetailsGoogleMapsModel.fromJson(Map<String, dynamic> json) =>
      PlaceDetailsGoogleMapsModel(
        lat: json['lat'],
        long: json['lng'],
      );
}