// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:provider/provider.dart';
// import 'location_provider.dart';

// class LocationMap extends StatefulWidget {
//   @override
//   _LocationMapState createState() => _LocationMapState();
// }

// class _LocationMapState extends State<LocationMap> {
//   BitmapDescriptor _pinLocationIcon;
//   Map<MarkerId, Marker> _markers;
//   Map<MarkerId, Marker> get markers => _markers;
//   final MarkerId markerId = MarkerId("1");

//   GoogleMapController _mapController;
//   GoogleMapController get mapController => _mapController;

//   Location _location;
//   Location get location => _location;
//   BitmapDescriptor get pinLocationIcon => _pinLocationIcon;

//   LatLng _locationPosition;
//   LatLng get locationPosition => _locationPosition;

//   bool locationServiceActive = true;

//   getUserLocation() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//     location.onLocationChanged.listen(
//       (LocationData currentLocation) {
//         _locationPosition = LatLng(
//           currentLocation.latitude,
//           currentLocation.longitude,
//         );

//         print(_locationPosition);

//         _markers.clear();

//         Marker marker = Marker(
//           markerId: markerId,
//           position: LatLng(
//             _locationPosition.latitude,
//             _locationPosition.longitude,
//           ),
//           icon: pinLocationIcon,
//           draggable: true,
//           onDragEnd: ((newPosition) {
//             _locationPosition = LatLng(
//               newPosition.latitude,
//               newPosition.longitude,
//             );
//           }),
//         );

//         _markers[markerId] = marker;
//       },
//     );
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Google Map live location"),
//         backgroundColor: Colors.redAccent,
//       ),
     
//       body: Column(
//         children: [
//           //_searchBar(),
//           Expanded(
//             child: GoogleMap(
//               mapType: MapType.normal,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(28.7041, 77.1025),
//                 zoom: 18,
//               ),
//               onMapCreated: (GoogleMapController controller) async {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
