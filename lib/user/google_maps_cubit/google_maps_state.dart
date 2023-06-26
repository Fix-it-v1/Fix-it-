part of 'google_maps_cubit.dart';

@immutable
abstract class GoogleMapsState {}

class GoogleMapsInitial extends GoogleMapsState {}

class SearchGoogleMapsLoadingState extends GoogleMapsState {}

class SearchGoogleMapsSuccessState extends GoogleMapsState
{
  final List<SearchMapsModel> searchMaps;

  SearchGoogleMapsSuccessState(this.searchMaps);
}

class SearchGoogleMapsErrorState extends GoogleMapsState {

}

class PlaceDetailsGoogleMapsLoadingState extends GoogleMapsState {}

class PlaceDetailsGoogleMapsSuccessState extends GoogleMapsState
{
  final PlaceDetailsGoogleMapsModel placeDetailsGoogleMaps;

  PlaceDetailsGoogleMapsSuccessState(this.placeDetailsGoogleMaps);
}

class PlaceDetailsGoogleMapsErrorState extends GoogleMapsState {

}