import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:project/model/place_details_google_map.dart';
import 'package:project/model/search_maps_model.dart';
import 'package:project/shared/constant.dart';
import 'package:project/shared/location_helper.dart';
import 'package:project/shared/place_Item_widget.dart';
import 'package:project/technical/Thome0.dart';
import 'package:project/user/google_maps_cubit/google_maps_cubit.dart';
import 'package:project/user/home0.dart';
import 'package:project/user/profile.dart';
import 'package:uuid/uuid.dart';

class GoogleMapScreen extends StatefulWidget {
  bool? updateUserLocation = false;
  bool? updateTechnicalLocation = false;
   GoogleMapScreen({Key? key , this.updateUserLocation , this.updateTechnicalLocation}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  List<SearchMapsModel> places = [];
  static final CameraPosition myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0,
    tilt: 0,
    zoom: 15,
    target: LatLng(position!.latitude, position!.longitude),
  );
  static Position? position;

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.determineCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: myCurrentLocationCameraPosition,
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      markers: markers,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller)
      {
        _mapController.complete(controller);
        buildCurrentLocationMarkerPlaceDetails();

      },
    );
  }

  void buildCurrentLocationMarkerPlaceDetails() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: MarkerId('2'),
      onTap: () {},
      infoWindow: InfoWindow(
        title: 'your current location',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

    );

    addMarkerToMarkersAndUpdateUi(currentLocationMarker);
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition));
  }

  FloatingSearchBarController searchController = FloatingSearchBarController();

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery
            .of(context)
            .orientation == Orientation.portrait;

    return BlocBuilder<GoogleMapsCubit, GoogleMapsState>(
      builder: (context, state) {
        return FloatingSearchBar(
          controller: searchController,
          automaticallyImplyBackButton: false,
          elevation: 6,
          hintStyle: Theme
              .of(context)
              .textTheme
              .headlineSmall,
          queryStyle: TextStyle(fontSize: 18),
          hint: 'Find a place...',
          border: BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(24),
          margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
          padding: EdgeInsets.fromLTRB(8, 0, 2, 0),
          height: 52,
          scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: Duration(microseconds: 600),
          transitionCurve: Curves.easeInOut,
          physics: BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0 : -1,
          openAxisAlignment: 0,
          width: isPortrait ? 420 : 500,
          debounceDelay: Duration(milliseconds: 500),
          onQueryChanged: (query) {
            print(
                '*****************************************************////////////////////***************');
            getPlacesSuggestions(query, context);
            print(
                '+++++++++++++++++++++++++++++++++++++++++++++++++////////////////////***************');
          },
          onFocusChanged: (_) {},
          transition: CircularFloatingSearchBarTransition(),
          actions:
          [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: Icon(Icons.place, color: Colors.green),
                onPressed: () {},
              ),
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:
                [
                  buildSuggestionsBloc(),
                  buildSelectedPlaceLocationBloc(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSuggestionsBloc() {
    return BlocBuilder<GoogleMapsCubit, GoogleMapsState>(
        builder: (context, state) {
          print(
              '///////////////////////////////////////////////////////////////////////////');
          if (state is SearchGoogleMapsSuccessState) {
            places = (state).searchMaps;
            if (places.length != 0) {
              print(
                  '//////////////////sucesssssssssssssss************************************////////');

              return buildPlacesList();
            } else {
              print(
                  '//////////////////Errrrrrrrrrrrror          *******************////////');

              return Container();
            }
          } else {
            print(
                '//////////////////Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr////////');
            return Container();
          }
        });
  }

  Widget buildPlacesList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return BlocBuilder<GoogleMapsCubit, GoogleMapsState>(
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                searchMapsPlaceSuggestion = places[index];
                searchController.close();
                getSelectedPlacedLocation(context);
              },
              child: PlaceItemWidget(
                placeSuggestion: places[index],
              ),
            );
          },
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void getPlacesSuggestions(String query, context) {
    final sessionToken = Uuid().v4();

    print(
        '--------------------------------- getPlacesSuggestions---------------------------------');

    BlocProvider.of<GoogleMapsCubit>(context)
        .searchInGoogleMaps(place: query, sessionToken: sessionToken);

    print(
        '--------------------------------- getPlacesSuggestions---------------------------------');
  }

  //ToDo: these variables for getPlaceLocation
  Set<Marker> markers = Set();
  late SearchMapsModel searchMapsPlaceSuggestion;
  late PlaceDetailsGoogleMapsModel selectedPlace;
  late Marker searchPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0,
      tilt: 0,
      target: LatLng(selectedPlace.lat, selectedPlace.long),
      zoom: 14,
    );
  }

  void getSelectedPlacedLocation(BuildContext context) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<GoogleMapsCubit>(context).getPlaceDetailsInGoogleMaps(
      placeId: searchMapsPlaceSuggestion.placeId,
      sessionToken: sessionToken,
    );
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<GoogleMapsCubit, GoogleMapsState>(
      listener: (context, state) {
        if (state is PlaceDetailsGoogleMapsSuccessState) {
          selectedPlace = (state).placeDetailsGoogleMaps;

          goToMySearchedForLocationPlaceDetails();
        }
      },
      child: Container(),
    );
  }

  Future<void> goToMySearchedForLocationPlaceDetails() async
  {
    buildCameraNewPosition();
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSearchedPlaceMarker();
  }

  void buildSearchedPlaceMarker() {
    searchPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: MarkerId('1'),
      onTap: () async
      {
        if(widget.updateUserLocation == true)
        {
           FirebaseFirestore.instance.collection('users').doc(uId).update({
             'city':searchMapsPlaceSuggestion.description,
           });
           Navigator.of(context).push( MaterialPageRoute(builder: (context)=>  home0()));
           ;
        }
        if(widget.updateTechnicalLocation == true)
        {
          FirebaseFirestore.instance.collection('providers').doc(uId).update({
            'city':searchMapsPlaceSuggestion.description,
          });
          Navigator.of(context).push( MaterialPageRoute(builder: (context)=>  Thome0()));
          ;
        }
        if(widget.updateUserLocation != true && widget.updateTechnicalLocation != true)
        {
          print('1234656989879878845465464565456445');
          Navigator.of(context).push( MaterialPageRoute(builder: (context)=>  profile(placeDes: searchMapsPlaceSuggestion.description , openDialog: true,)));
        }




        // Navigator.of(context).toDiagnosticsNode();
      },
      infoWindow: InfoWindow(
        title: '${searchMapsPlaceSuggestion.description}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

    );

    addMarkerToMarkersAndUpdateUi(searchPlaceMarker);
  }


  void addMarkerToMarkersAndUpdateUi(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }


  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleMapsCubit(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            position != null
                ? buildMap()
                : Center(child: Container(child: CircularProgressIndicator())),
            buildFloatingSearchBar(),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: _goToMyCurrentLocation,
            child: Icon(Icons.place),
          ),
        ),
      ),
    );
  }
}
