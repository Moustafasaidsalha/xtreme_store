// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:extreme_store/app/constants/colors_constants.dart';
// import 'package:extreme_store/app/helper/location_helper.dart';
//
// class MapView extends StatefulWidget {
//   const MapView({Key? key}) : super(key: key);
//
//   @override
//   _MapViewState createState() => _MapViewState();
// }
//
// class _MapViewState extends State<MapView> {
//   static Position? position;
//   Completer<GoogleMapController> _mapController = Completer();
//   final Set<Marker> _markers = {};
//
//   static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
//     bearing: 0.0,
//     target: LatLng(position!.latitude, position!.longitude),
//     tilt: 0.0,
//     zoom: 17,
//   );
//
//   @override
//   initState() {
//     super.initState();
//     getMyCurrentLocation();
//   }
//
//   Future<void> getMyCurrentLocation() async {
//     position = await LocationHelper.getCurrentLocation().whenComplete(() {
//       // try{
//       //
//       //   print(position!.latitude);
//       //
//       // }catch(e){print(e.toString());}
//
//       setState(() {});
//     });
//   }
//
//   Widget buildMap() {
//     return GoogleMap(
//       mapType: MapType.normal,
//       myLocationEnabled: true,
//       zoomControlsEnabled: false,
//       myLocationButtonEnabled: false,
//       initialCameraPosition: _myCurrentLocationCameraPosition,
//       markers: _markers,
//       onMapCreated: (GoogleMapController controller) {
//         _mapController.complete(controller);
//       },
//       onTap: (argument) {
//         if(_markers.isNotEmpty)
//         {
//           _markers.clear();
//         }
//         setState(() {
//           _markers.add(Marker(
//             // This marker id can be anything that uniquely identifies each marker.
//             markerId: MarkerId("1"),
//             position: argument,
//             icon: BitmapDescriptor.defaultMarker,
//           ));
//         });
//         },
//     );
//   }
//
//   Future<void> _goToMyCurrentLocation() async {
//     final GoogleMapController controller = await _mapController.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           position != null
//               ? buildMap()
//               : Center(
//                   child: Container(
//                     child: const CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//       floatingActionButton: Container(
//         margin: EdgeInsets.fromLTRB(8.r, 0.r, 8.r, 80.r),
//         child: FloatingActionButton(
//           backgroundColor: ColorsConstants.white,
//           shape: const CircleBorder(),
//           onPressed: _goToMyCurrentLocation,
//           child: const Icon(
//             Icons.my_location_outlined,
//             color: ColorsConstants.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
