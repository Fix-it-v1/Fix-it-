import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/model/place_details_google_map.dart';
import 'package:project/model/search_maps_model.dart';
import 'package:project/shared/api_constant.dart';

part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(GoogleMapsInitial());

  static GoogleMapsCubit get(context) => BlocProvider.of(context);

  List<SearchMapsModel> searchMaps = [];
  Future<List<SearchMapsModel>> searchInGoogleMaps({
    required String place,
    required String sessionToken,
})async
  {
    emit(SearchGoogleMapsLoadingState());
    final response = await Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 20*1000,
        receiveTimeout: 20*1000,
      ),
    ).get(ApiConstant.searchInGoogleMaps , queryParameters:
    {
      'input': place,
      'types':'address',
      'components':'country:eg',
      'key': ApiConstant.apiKeyGoogleMaps,
      'sessiontoken': sessionToken,
    });

    print(response);

    if(response.statusCode == 200)
    {
      print("I am in google maps  cubit success **************************************************************");

      searchMaps = List<SearchMapsModel>.from((response.data["predictions"]as List).map((e) => SearchMapsModel.fromJson(e)));
      emit(SearchGoogleMapsSuccessState(searchMaps));
      return searchMaps;
    }else
    {
      print("I am in google maps cubit error**************************************************************");

      emit(SearchGoogleMapsErrorState());
      throw Exception('search location error');



    }


  }


  PlaceDetailsGoogleMapsModel placeDetailsGoogleMaps = PlaceDetailsGoogleMapsModel(lat: 1, long: 1);

  Future<PlaceDetailsGoogleMapsModel> getPlaceDetailsInGoogleMaps({
    required String placeId,
    required String sessionToken,
} ) async
  {
  emit(PlaceDetailsGoogleMapsLoadingState());
    final response = await Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 20*1000,
        receiveTimeout: 20*1000,
      ),
    ).get(ApiConstant.placeDetailsInGoogleMaps , queryParameters:
    {
      'place_id': placeId,
      'fields':'geometry',
      'key': ApiConstant.apiKeyGoogleMaps,
      'sessiontoken': sessionToken,
    });

    print(response);

    if(response.statusCode == 200)
    {
      print("I am in Place Details google maps  data source success **************************************************************");
      placeDetailsGoogleMaps =  PlaceDetailsGoogleMapsModel.fromJson(response.data['result']['geometry']['location']);
      emit(PlaceDetailsGoogleMapsSuccessState(placeDetailsGoogleMaps));
      print(placeDetailsGoogleMaps);
      return placeDetailsGoogleMaps;
    }else
    {
      print("I am in google maps data source error**************************************************************");
      emit(PlaceDetailsGoogleMapsErrorState());
      throw Exception('place location error');
    }


  }

}
