// import 'package:barberside/auth/barber.dart';
// import 'package:flutter/material.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Updatelocation extends StatefulWidget {
//   const Updatelocation({super.key});

//   @override
//   State<Updatelocation> createState() => _UpdatelocationState();
// }

// class _UpdatelocationState extends State<Updatelocation> {
//   final barber = Barber();
//   String _firstName = '';
//   double longitude = 0;
//   double latitude = 0;
//   String _locationName = 'loading ...';
//   bool _isloading = true;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print('first print');
//     getLocation();
//     print('middle print');
//     loadLocation();
//     print('last print');
//   }

//   void getUserDetails() async {
//     final firstName = await barber.retrieveFirstName();
//     _firstName = firstName!;
//     setState(() {
//       _isloading = false;
//     });
//   }

//   void getLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     setState(() {
//       longitude = position.longitude;
//       latitude = position.latitude;
//       _isloading = false;
//     });

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setDouble('longitude', longitude);
//     await prefs.setDouble('latitude', latitude);

//     getAddressFromLatLng(latitude, longitude);
//   }

//   void getAddressFromLatLng(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       Placemark place = placemarks[0];
//       setState(() {
//         _locationName = "${place.locality}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   void loadLocation() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       longitude = prefs.getDouble('longitude') ?? 0;
//       latitude = prefs.getDouble('latitude') ?? 0;
//     });
//     getAddressFromLatLng(latitude, longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
