// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// export 'dart:async' show Completer;

// export 'package:google_maps_flutter/google_maps_flutter.dart' hide LatLng;

// enum GoogleMapStyle {
//   standard,
//   silver,
//   retro,
//   dark,
//   night,
//   aubergine,
// }

// enum GoogleMarkerColor {
//   red,
//   orange,
//   yellow,
//   green,
//   cyan,
//   azure,
//   blue,
//   violet,
//   magenta,
//   rose,
// }

// class FlutterFlowMarker {
//   const FlutterFlowMarker(this.markerId, this.location, [this.onTap]);
//   final String markerId;
//   final LatLng location;
//   final Future Function()? onTap;
// }

// class FlutterFlowGoogleMap extends StatefulWidget {
//   const FlutterFlowGoogleMap({
//     required this.controller,
//     this.onCameraIdle,
//     this.initialLocation,
//     this.markers = const [],
//     this.markerColor = GoogleMarkerColor.red,
//     this.mapType = MapType.normal,
//     this.style = GoogleMapStyle.standard,
//     this.initialZoom = 12,
//     this.allowInteraction = true,
//     this.allowZoom = true,
//     this.showZoomControls = true,
//     this.showLocation = true,
//     this.showCompass = false,
//     this.showMapToolbar = false,
//     this.showTraffic = false,
//     this.centerMapOnMarkerTap = false,
//     Key? key,
//   }) : super(key: key);

//   final Completer<GoogleMapController> controller;
//   final Function(LatLng)? onCameraIdle;
//   final LatLng? initialLocation;
//   final Iterable<FlutterFlowMarker> markers;
//   final GoogleMarkerColor markerColor;
//   final MapType mapType;
//   final GoogleMapStyle style;
//   final double initialZoom;
//   final bool allowInteraction;
//   final bool allowZoom;
//   final bool showZoomControls;
//   final bool showLocation;
//   final bool showCompass;
//   final bool showMapToolbar;
//   final bool showTraffic;
//   final bool centerMapOnMarkerTap;

//   @override
//   State<StatefulWidget> createState() => _FlutterFlowGoogleMapState();
// }

// class _FlutterFlowGoogleMapState extends State<FlutterFlowGoogleMap> {
//   double get initialZoom => max(double.minPositive, widget.initialZoom);
//   LatLng get initialPosition =>
//       widget.initialLocation?.toGoogleMaps() ?? const LatLng(0.0, 0.0);

//   late Completer<GoogleMapController> _controller;
//   late LatLng currentMapCenter;

//   void onCameraIdle() => widget.onCameraIdle?.call(currentMapCenter.toLatLng());

//   @override
//   void initState() {
//     super.initState();
//     currentMapCenter = initialPosition;
//     _controller = widget.controller;
//   }

//   @override
//   Widget build(BuildContext context) => AbsorbPointer(
//         absorbing: !widget.allowInteraction,
//         child: GoogleMap(
//           onMapCreated: (controller) async {
//             _controller.complete(controller);
//             await controller.setMapStyle(googleMapStyleStrings[widget.style]);
//           },
//           onCameraIdle: onCameraIdle,
//           onCameraMove: (position) => currentMapCenter = position.target,
//           initialCameraPosition: CameraPosition(
//             target: initialPosition,
//             zoom: initialZoom,
//           ),
//           mapType: widget.mapType,
//           zoomGesturesEnabled: widget.allowZoom,
//           zoomControlsEnabled: widget.showZoomControls,
//           myLocationEnabled: widget.showLocation,
//           compassEnabled: widget.showCompass,
//           mapToolbarEnabled: widget.showMapToolbar,
//           trafficEnabled: widget.showTraffic,
//           markers: widget.markers
//               .map(
//                 (m) => Marker(
//                   markerId: MarkerId(m.markerId),
//                   position: m.location.toGoogleMaps(),
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                       googleMarkerColorMap[widget.markerColor]!),
//                   onTap: () async {
//                     await m.onTap?.call();
//                     if (widget.centerMapOnMarkerTap) {
//                       final controller = await _controller.future;
//                       await controller.animateCamera(
//                         CameraUpdate.newLatLng(m.location.toGoogleMaps()),
//                       );
//                       currentMapCenter = m.location.toGoogleMaps();
//                       onCameraIdle();
//                     }
//                   },
//                 ),
//               )
//               .toSet(),
//         ),
//       );
// }

// extension ToGoogleMapsLatLng on LatLng {
//   LatLng toGoogleMaps() => LatLng(latitude, longitude);
// }

// extension GoogleMapsToLatLng on LatLng {
//   LatLng toLatLng() => LatLng(latitude, longitude);
// }

// Map<GoogleMapStyle, String> googleMapStyleStrings = {
//   GoogleMapStyle.standard: '[]',
//   GoogleMapStyle.silver:
//       r'[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]',
//   GoogleMapStyle.retro:
//       r'[{"elementType":"geometry","stylers":[{"color":"#ebe3cd"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#523735"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b2a6"}]},{"featureType":"administrative.land_parcel","elementType":"geometry.stroke","stylers":[{"color":"#dcd2be"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#ae9e90"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#93817c"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#a5b076"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#447530"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#fdfcf8"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8c967"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e9bc62"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#e98d58"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#db8555"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#806b63"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"transit.line","elementType":"labels.text.fill","stylers":[{"color":"#8f7d77"}]},{"featureType":"transit.line","elementType":"labels.text.stroke","stylers":[{"color":"#ebe3cd"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#b9d3c2"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#92998d"}]}]',
//   GoogleMapStyle.dark:
//       r'[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]',
//   GoogleMapStyle.night:
//       r'[{"elementType":"geometry","stylers":[{"color":"#242f3e"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#746855"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#242f3e"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#263c3f"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#6b9a76"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#38414e"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#212a37"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#9ca5b3"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#746855"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#1f2835"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#f3d19c"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2f3948"}]},{"featureType":"transit.station","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#17263c"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#515c6d"}]},{"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#17263c"}]}]',
//   GoogleMapStyle.aubergine:
//       r'[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#64779e"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"color":"#334e87"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#023e58"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#283d6a"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#6f9ba5"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#023e58"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#3C7680"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"road","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2c6675"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#b0d5ce"}]},{"featureType":"road.highway","elementType":"labels.text.stroke","stylers":[{"color":"#023e58"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"transit","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"transit.line","elementType":"geometry.fill","stylers":[{"color":"#283d6a"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#3a4762"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#4e6d70"}]}]',
// };

// Map<GoogleMarkerColor, double> googleMarkerColorMap = {
//   GoogleMarkerColor.red: 0.0,
//   GoogleMarkerColor.orange: 30.0,
//   GoogleMarkerColor.yellow: 60.0,
//   GoogleMarkerColor.green: 120.0,
//   GoogleMarkerColor.cyan: 180.0,
//   GoogleMarkerColor.azure: 210.0,
//   GoogleMarkerColor.blue: 240.0,
//   GoogleMarkerColor.violet: 270.0,
//   GoogleMarkerColor.magenta: 300.0,
//   GoogleMarkerColor.rose: 330.0,
// };

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:http/http.dart';
// import 'package:product/Helper/CommonWidgets.dart';
// import 'package:product/Screens/GoogleMapPlacePicker/providers/place_provider.dart';
// import 'package:product/Screens/GoogleMapPlacePicker/src/autocomplete_search.dart';
// import 'package:product/Screens/GoogleMapPlacePicker/src/controllers/autocomplete_search_controller.dart';
// import 'package:product/Screens/GoogleMapPlacePicker/src/google_map_place_picker.dart';
// import 'package:product/Screens/GoogleMapPlacePicker/src/models/pick_result.dart';

// import 'package:provider/provider.dart';
// import 'dart:io' show Platform;

// enum PinState { Preparing, Idle, Dragging }

// enum SearchingState { Idle, Searching }

// class PlacePicker extends StatefulWidget {
//   PlacePicker({
//     Key? key,
//     required this.apiKey,
//     this.onPlacePicked,
//     required this.initialPosition,
//     this.useCurrentLocation,
//     this.desiredLocationAccuracy = LocationAccuracy.high,
//     this.onMapCreated,
//     this.hintText,
//     this.searchingText,
//     // this.searchBarHeight,
//     // this.contentPadding,
//     this.onAutoCompleteFailed,
//     this.onGeocodingSearchFailed,
//     this.proxyBaseUrl,
//     this.httpClient,
//     this.selectedPlaceWidgetBuilder,
//     this.pinBuilder,
//     this.autoCompleteDebounceInMilliseconds = 500,
//     this.cameraMoveDebounceInMilliseconds = 750,
//     this.initialMapType = MapType.normal,
//     this.enableMapTypeButton = true,
//     this.enableMyLocationButton = true,
//     this.myLocationButtonCooldown = 10,
//     this.usePinPointingSearch = true,
//     this.usePlaceDetailSearch = false,
//     this.autocompleteOffset,
//     this.autocompleteRadius,
//     this.autocompleteLanguage,
//     this.autocompleteComponents,
//     this.autocompleteTypes,
//     this.strictbounds,
//     this.region,
//     this.selectInitialPosition = false,
//     this.resizeToAvoidBottomInset = true,
//     this.initialSearchString,
//     this.searchForInitialValue = false,
//     this.forceAndroidLocationManager = false,
//     this.forceSearchOnZoomChanged = false,
//     this.automaticallyImplyAppBarLeading = true,
//     this.autocompleteOnTrailingWhitespace = false,
//     this.hidePlaceDetailsWhenDraggingPin = true,
//   }) : super(key: key);

//   final String apiKey;

//   final LatLng initialPosition;
//   final bool? useCurrentLocation;
//   final LocationAccuracy desiredLocationAccuracy;

//   final MapCreatedCallback? onMapCreated;

//   final String? hintText;
//   final String? searchingText;
//   // final double searchBarHeight;
//   // final EdgeInsetsGeometry contentPadding;

//   final ValueChanged<String>? onAutoCompleteFailed;
//   final ValueChanged<String>? onGeocodingSearchFailed;
//   final int autoCompleteDebounceInMilliseconds;
//   final int cameraMoveDebounceInMilliseconds;

//   final MapType initialMapType;
//   final bool enableMapTypeButton;
//   final bool enableMyLocationButton;
//   final int myLocationButtonCooldown;

//   final bool usePinPointingSearch;
//   final bool usePlaceDetailSearch;

//   final num? autocompleteOffset;
//   final num? autocompleteRadius;
//   final String? autocompleteLanguage;
//   final List<String>? autocompleteTypes;
//   final List<Component>? autocompleteComponents;
//   final bool? strictbounds;
//   final String? region;

//   /// If true the [body] and the scaffold's floating widgets should size
//   /// themselves to avoid the onscreen keyboard whose height is defined by the
//   /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
//   ///
//   /// For example, if there is an onscreen keyboard displayed above the
//   /// scaffold, the body can be resized to avoid overlapping the keyboard, which
//   /// prevents widgets inside the body from being obscured by the keyboard.
//   ///
//   /// Defaults to true.
//   final bool resizeToAvoidBottomInset;

//   final bool selectInitialPosition;

//   /// By using default setting of Place Picker, it will result result when user hits the select here button.
//   ///
//   /// If you managed to use your own [selectedPlaceWidgetBuilder], then this WILL NOT be invoked, and you need use data which is
//   /// being sent with [selectedPlaceWidgetBuilder].
//   final ValueChanged<PickResult>? onPlacePicked;

//   /// optional - builds selected place's UI
//   ///
//   /// It is provided by default if you leave it as a null.
//   /// INPORTANT: If this is non-null, [onPlacePicked] will not be invoked, as there will be no default 'Select here' button.
//   final SelectedPlaceWidgetBuilder? selectedPlaceWidgetBuilder;

//   /// optional - builds customized pin widget which indicates current pointing position.
//   ///
//   /// It is provided by default if you leave it as a null.
//   final PinBuilder? pinBuilder;

//   /// optional - sets 'proxy' value in google_maps_webservice
//   ///
//   /// In case of using a proxy the baseUrl can be set.
//   /// The apiKey is not required in case the proxy sets it.
//   /// (Not storing the apiKey in the app is good practice)
//   final String? proxyBaseUrl;

//   /// optional - set 'client' value in google_maps_webservice
//   ///
//   /// In case of using a proxy url that requires authentication
//   /// or custom configuration
//   final BaseClient? httpClient;

//   /// Initial value of autocomplete search
//   final String? initialSearchString;

//   /// Whether to search for the initial value or not
//   final bool searchForInitialValue;

//   /// On Android devices you can set [forceAndroidLocationManager]
//   /// to true to force the plugin to use the [LocationManager] to determine the
//   /// position instead of the [FusedLocationProviderClient]. On iOS this is ignored.
//   final bool forceAndroidLocationManager;

//   /// Allow searching place when zoom has changed. By default searching is disabled when zoom has changed in order to prevent unwilling API usage.
//   final bool forceSearchOnZoomChanged;

//   /// Whether to display appbar backbutton. Defaults to true.
//   final bool automaticallyImplyAppBarLeading;

//   /// Will perform an autocomplete search, if set to true. Note that setting
//   /// this to true, while providing a smoother UX experience, may cause
//   /// additional unnecessary queries to the Places API.
//   ///
//   /// Defaults to false.
//   final bool autocompleteOnTrailingWhitespace;

//   final bool hidePlaceDetailsWhenDraggingPin;

//   @override
//   _PlacePickerState createState() => _PlacePickerState();
// }

// class _PlacePickerState extends State<PlacePicker> {
//   GlobalKey appBarKey = GlobalKey();
//   Future<PlaceProvider>? _futureProvider;
//   PlaceProvider? provider;
//   SearchBarController searchBarController = SearchBarController();

//   @override
//   void initState() {
//     super.initState();

//     _futureProvider = _initPlaceProvider();
//   }

//   @override
//   void dispose() {
//     searchBarController.dispose();

//     super.dispose();
//   }

//   Future<PlaceProvider> _initPlaceProvider() async {
//     final headers = await GoogleApiHeaders().getHeaders();
//     final provider = PlaceProvider(
//       widget.apiKey,
//       widget.proxyBaseUrl,
//       widget.httpClient,
//       headers,
//     );
//     provider.sessionToken = Uuid().generateV4();
//     provider.desiredAccuracy = widget.desiredLocationAccuracy;
//     provider.setMapType(widget.initialMapType);

//     return provider;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         searchBarController.clearOverlay();
//         return Future.value(true);
//       },
//       child: FutureBuilder<PlaceProvider>(
//         future: _futureProvider,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             provider = snapshot.data;

//             return MultiProvider(
//               providers: [
//                 ChangeNotifierProvider<PlaceProvider>.value(value: provider!),
//               ],
//               child: Scaffold(
//                 key: ValueKey<int>(provider.hashCode),
//                 resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//                 extendBodyBehindAppBar: true,
//                 appBar: AppBar(
//                   key: appBarKey,
//                   automaticallyImplyLeading: false,
//                   iconTheme: Theme.of(context).iconTheme,
//                   elevation: 0,
//                   backgroundColor: Colors.transparent,
//                   titleSpacing: 0.0,
//                   title: _buildSearchBar(context),
//                   systemOverlayStyle: statusBarDesign(),
//                 ),
//                 body: _buildMapWithLocation(),
//               ),
//             );
//           }

//           final children = <Widget>[];
//           if (snapshot.hasError) {
//             children.addAll([
//               Icon(
//                 Icons.error_outline,
//                 color: Theme.of(context).errorColor,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: Text('Error: ${snapshot.error}'),
//               )
//             ]);
//           } else {
//             children.add(CircularProgressIndicator());
//           }

//           return Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: children,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSearchBar(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         widget.automaticallyImplyAppBarLeading
//             ? IconButton(
//                 onPressed: () => Navigator.maybePop(context),
//                 icon: Icon(
//                   Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
//                 ),
//                 padding: EdgeInsets.zero)
//             : SizedBox(width: 15),
//         Expanded(
//           child: AutoCompleteSearch(
//               appBarKey: appBarKey,
//               searchBarController: searchBarController,
//               sessionToken: provider!.sessionToken,
//               hintText: widget.hintText,
//               searchingText: widget.searchingText,
//               debounceMilliseconds: widget.autoCompleteDebounceInMilliseconds,
//               onPicked: (prediction) {
//                 _pickPrediction(prediction);
//               },
//               onSearchFailed: (status) {
//                 if (widget.onAutoCompleteFailed != null) {
//                   widget.onAutoCompleteFailed!(status);
//                 }
//               },
//               autocompleteOffset: widget.autocompleteOffset,
//               autocompleteRadius: widget.autocompleteRadius,
//               autocompleteLanguage: widget.autocompleteLanguage,
//               autocompleteComponents: widget.autocompleteComponents,
//               autocompleteTypes: widget.autocompleteTypes,
//               strictbounds: widget.strictbounds,
//               region: widget.region,
//               initialSearchString: widget.initialSearchString,
//               searchForInitialValue: widget.searchForInitialValue,
//               autocompleteOnTrailingWhitespace:
//                   widget.autocompleteOnTrailingWhitespace),
//         ),
//         SizedBox(width: 5),
//       ],
//     );
//   }

//   _pickPrediction(Prediction prediction) async {
//     provider!.placeSearchingState = SearchingState.Searching;

//     final PlacesDetailsResponse response =
//         await provider!.places.getDetailsByPlaceId(
//       prediction.placeId!,
//       sessionToken: provider!.sessionToken,
//       language: widget.autocompleteLanguage,
//     );

//     if (response.errorMessage?.isNotEmpty == true ||
//         response.status == "REQUEST_DENIED") {
//       if (widget.onAutoCompleteFailed != null) {
//         widget.onAutoCompleteFailed!(response.status);
//       }
//       return;
//     }

//     provider!.selectedPlace = PickResult.fromPlaceDetailResult(response.result);

//     // Prevents searching again by camera movement.
//     provider!.isAutoCompleteSearching = true;

//     await _moveTo(provider!.selectedPlace!.geometry!.location.lat,
//         provider!.selectedPlace!.geometry!.location.lng);

//     provider!.placeSearchingState = SearchingState.Idle;
//   }

//   _moveTo(double latitude, double longitude) async {
//     GoogleMapController? controller = provider!.mapController;
//     if (controller == null) return;

//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(latitude, longitude),
//           zoom: 16,
//         ),
//       ),
//     );
//   }

//   _moveToCurrentPosition() async {
//     if (provider!.currentPosition != null) {
//       await _moveTo(provider!.currentPosition!.latitude,
//           provider!.currentPosition!.longitude);
//     }
//   }

//   Widget _buildMapWithLocation() {
//     if (widget.useCurrentLocation != null && widget.useCurrentLocation!) {
//       return FutureBuilder(
//           future: provider!
//               .updateCurrentLocation(widget.forceAndroidLocationManager),
//           builder: (context, snap) {
//             if (snap.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               if (provider!.currentPosition == null) {
//                 return _buildMap(widget.initialPosition);
//               } else {
//                 return _buildMap(LatLng(provider!.currentPosition!.latitude,
//                     provider!.currentPosition!.longitude));
//               }
//             }
//           });
//     } else {
//       return FutureBuilder(
//         future: Future.delayed(Duration(milliseconds: 1)),
//         builder: (context, snap) {
//           if (snap.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return _buildMap(widget.initialPosition);
//           }
//         },
//       );
//     }
//   }

//   Widget _buildMap(LatLng initialTarget) {
//     return GoogleMapPlacePicker(
//       initialTarget: initialTarget,
//       appBarKey: appBarKey,
//       selectedPlaceWidgetBuilder: widget.selectedPlaceWidgetBuilder,
//       pinBuilder: widget.pinBuilder,
//       onSearchFailed: widget.onGeocodingSearchFailed,
//       debounceMilliseconds: widget.cameraMoveDebounceInMilliseconds,
//       enableMapTypeButton: widget.enableMapTypeButton,
//       enableMyLocationButton: widget.enableMyLocationButton,
//       usePinPointingSearch: widget.usePinPointingSearch,
//       usePlaceDetailSearch: widget.usePlaceDetailSearch,
//       onMapCreated: widget.onMapCreated,
//       selectInitialPosition: widget.selectInitialPosition,
//       language: widget.autocompleteLanguage,
//       forceSearchOnZoomChanged: widget.forceSearchOnZoomChanged,
//       hidePlaceDetailsWhenDraggingPin: widget.hidePlaceDetailsWhenDraggingPin,
//       onToggleMapType: () {
//         provider!.switchMapType();
//       },
//       onMyLocation: () async {
//         // Prevent to click many times in short period.
//         if (provider!.isOnUpdateLocationCooldown == false) {
//           provider!.isOnUpdateLocationCooldown = true;
//           Timer(Duration(seconds: widget.myLocationButtonCooldown), () {
//             provider!.isOnUpdateLocationCooldown = false;
//           });
//           await provider!
//               .updateCurrentLocation(widget.forceAndroidLocationManager);
//           await _moveToCurrentPosition();
//         }
//       },
//       onMoveStart: () {
//         searchBarController.reset();
//       },
//       onPlacePicked: widget.onPlacePicked,
//     );
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

export 'dart:async' show Completer;

export 'package:google_maps_flutter/google_maps_flutter.dart' hide LatLng;

export 'lat_lng.dart' show LatLng;

enum GoogleMapStyle {
  standard,
  silver,
  retro,
  dark,
  night,
  aubergine,
}

enum GoogleMarkerColor {
  red,
  orange,
  yellow,
  green,
  cyan,
  azure,
  blue,
  violet,
  magenta,
  rose,
}

class FlutterFlowMarker {
  const FlutterFlowMarker(this.markerId, this.location, [this.onTap]);
  final String markerId;
  final LatLng location;
  final Future Function()? onTap;
}

class CommonGoogleMap extends StatefulWidget {
  const CommonGoogleMap({
    required this.controller,
    this.onCameraIdle,
    this.initialLocation,
    this.markers = const [],
    this.markerColor = GoogleMarkerColor.red,
    this.mapType = MapType.normal,
    this.style = GoogleMapStyle.standard,
    this.initialZoom = 12,
    this.allowInteraction = true,
    this.allowZoom = true,
    this.showZoomControls = true,
    this.showLocation = true,
    this.showCompass = false,
    this.showMapToolbar = false,
    this.showTraffic = false,
    this.centerMapOnMarkerTap = false,
    this.myLocationButtonEnabled = false,
    Key? key,
  }) : super(key: key);

  final Completer<GoogleMapController> controller;
  final Function(LatLng)? onCameraIdle;
  final LatLng? initialLocation;
  final Iterable<FlutterFlowMarker> markers;
  final GoogleMarkerColor markerColor;
  final MapType mapType;
  final GoogleMapStyle style;
  final double initialZoom;
  final bool allowInteraction;
  final bool allowZoom;
  final bool showZoomControls;
  final bool showLocation;
  final bool showCompass;
  final bool showMapToolbar;
  final bool showTraffic;
  final bool centerMapOnMarkerTap;
  final bool myLocationButtonEnabled;

  @override
  State<StatefulWidget> createState() => _CommonGoogleMapState();
}

class _CommonGoogleMapState extends State<CommonGoogleMap> {
  double get initialZoom => max(double.minPositive, widget.initialZoom);
  LatLng get initialPosition =>
      widget.initialLocation?.toGoogleMaps() ?? const LatLng(0.0, 0.0);

  late Completer<GoogleMapController> _controller;
  late LatLng currentMapCenter;

  void onCameraIdle() => widget.onCameraIdle?.call(currentMapCenter.toLatLng());

  @override
  void initState() {
    super.initState();
    currentMapCenter = initialPosition;
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !widget.allowInteraction,
        child: GoogleMap(
          padding: EdgeInsets.only(bottom: 100.h),
          onMapCreated: (controller) async {
            _controller.complete(controller);
            await controller.setMapStyle(googleMapStyleStrings[widget.style]);
          },
          onCameraIdle: onCameraIdle,
          onCameraMove: (position) => currentMapCenter = position.target,
          initialCameraPosition: CameraPosition(
              target: initialPosition,
              bearing: 192.8334901395799,
              tilt: 59.440717697143555,
              zoom: 19.151926040649414),
          mapType: widget.mapType,
          zoomGesturesEnabled: widget.allowZoom,
          zoomControlsEnabled: widget.showZoomControls,
          myLocationEnabled: widget.showLocation,
          compassEnabled: widget.showCompass,
          mapToolbarEnabled: widget.showMapToolbar,
          trafficEnabled: widget.showTraffic,
          myLocationButtonEnabled: widget.myLocationButtonEnabled,
          markers: widget.markers
              .map(
                (m) => Marker(
                  markerId: MarkerId(m.markerId),
                  position: m.location.toGoogleMaps(),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      googleMarkerColorMap[widget.markerColor]!),
                  onTap: () async {
                    await m.onTap?.call();
                    if (widget.centerMapOnMarkerTap) {
                      final controller = await _controller.future;
                      await controller.animateCamera(
                        CameraUpdate.newLatLng(m.location.toGoogleMaps()),
                      );
                      currentMapCenter = m.location.toGoogleMaps();
                      onCameraIdle();
                    }
                  },
                ),
              )
              .toSet(),
        ),
      );
}

extension ToGoogleMapsLatLng on LatLng {
  LatLng toGoogleMaps() => LatLng(latitude, longitude);
}

extension GoogleMapsToLatLng on LatLng {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

Map<GoogleMapStyle, String> googleMapStyleStrings = {
  GoogleMapStyle.standard: '[]',
  GoogleMapStyle.silver:
      r'[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]',
  GoogleMapStyle.retro:
      r'[{"elementType":"geometry","stylers":[{"color":"#ebe3cd"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#523735"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b2a6"}]},{"featureType":"administrative.land_parcel","elementType":"geometry.stroke","stylers":[{"color":"#dcd2be"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#ae9e90"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#93817c"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#a5b076"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#447530"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#fdfcf8"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8c967"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e9bc62"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#e98d58"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#db8555"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#806b63"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"transit.line","elementType":"labels.text.fill","stylers":[{"color":"#8f7d77"}]},{"featureType":"transit.line","elementType":"labels.text.stroke","stylers":[{"color":"#ebe3cd"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#b9d3c2"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#92998d"}]}]',
  GoogleMapStyle.dark:
      r'[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]',
  GoogleMapStyle.night:
      r'[{"elementType":"geometry","stylers":[{"color":"#242f3e"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#746855"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#242f3e"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#263c3f"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#6b9a76"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#38414e"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#212a37"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#9ca5b3"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#746855"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#1f2835"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#f3d19c"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2f3948"}]},{"featureType":"transit.station","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#17263c"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#515c6d"}]},{"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#17263c"}]}]',
  GoogleMapStyle.aubergine:
      r'[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#64779e"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"color":"#334e87"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#023e58"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#283d6a"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#6f9ba5"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#023e58"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#3C7680"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"road","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2c6675"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#b0d5ce"}]},{"featureType":"road.highway","elementType":"labels.text.stroke","stylers":[{"color":"#023e58"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"transit","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"transit.line","elementType":"geometry.fill","stylers":[{"color":"#283d6a"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#3a4762"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#4e6d70"}]}]',
};

Map<GoogleMarkerColor, double> googleMarkerColorMap = {
  GoogleMarkerColor.red: 0.0,
  GoogleMarkerColor.orange: 30.0,
  GoogleMarkerColor.yellow: 60.0,
  GoogleMarkerColor.green: 120.0,
  GoogleMarkerColor.cyan: 180.0,
  GoogleMarkerColor.azure: 210.0,
  GoogleMarkerColor.blue: 240.0,
  GoogleMarkerColor.violet: 270.0,
  GoogleMarkerColor.magenta: 300.0,
  GoogleMarkerColor.rose: 330.0,
};
