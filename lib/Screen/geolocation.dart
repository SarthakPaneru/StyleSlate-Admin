// // main.dart

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:barberside/config/api_requests.dart';

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   double? _latitude;
//   double? _longitude;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, handle appropriately
//       return;
//     }

//     // Check location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, handle appropriately
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately
//       return;
//     }

//     // When permissions are granted, get the current position
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       setState(() {
//         _latitude = position.latitude;
//         _longitude = position.longitude;
//       });

//       // await LocationService.sendLocationData(_latitude!, _longitude!);
//     } catch (e) {
//       // Handle exceptions
//       print('Failed to get current location: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Geolocator Example'),
//       ),
//       body: Center(
//         child: _latitude == null || _longitude == null
//             ? CircularProgressIndicator()
//             : Text('Latitude: $_latitude\nLongitude: $_longitude'),
//       ),
//     );
//   }
// }
