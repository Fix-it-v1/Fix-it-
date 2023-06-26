class SearchMapsModel {
  final String description;
  final String placeId;

  SearchMapsModel({required this.description, required this.placeId});
  factory SearchMapsModel.fromJson(Map<String, dynamic> json) =>
      SearchMapsModel(
        description: json['description'],
        placeId: json['place_id'],
      );

}