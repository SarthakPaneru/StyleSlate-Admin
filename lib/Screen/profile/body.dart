import 'package:barberside/Screen/login.dart';
import 'package:barberside/Screen/profile/changepassword.dart';
import 'package:barberside/auth/barber.dart';
import 'package:barberside/auth/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Myaccount.dart';
import 'helpcenterscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final barber = Barber();
  String _firstName = '';
  double longitude = 0;
  double latitude = 0;
  String _locationName = 'loading ...';
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getLocation();
    loadLocation();
  }

  void getUserDetails() async {
    final firstName = await barber.retrieveFirstName();
    setState(() {
      _firstName = firstName ?? '';
      _isloading = false;
    });
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
      _isloading = false;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('longitude', longitude);
    await prefs.setDouble('latitude', latitude);

    getAddressFromLatLng(latitude, longitude);
  }

  void getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];
      setState(() {
        _locationName = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      longitude = prefs.getDouble('longitude') ?? 0;
      latitude = prefs.getDouble('latitude') ?? 0;
    });
    getAddressFromLatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff323345),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff323345),
            const Color(0xff323345).withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              ProfilePage(
                firstName: _firstName,
                locationName: _locationName,
                onUpdateLocation: getLocation,
              ),
              const SizedBox(height: 20),
              _buildProfileMenu(
                context,
                "My Account",
                "lib/assets/images/User Icon.svg",
                () => navigateTo(context, const MyAccountScreen()),
              ),
              _buildProfileMenu(
                context,
                "Notifications",
                "lib/assets/images/Bell.svg",
                () {},
              ),
              _buildProfileMenu(
                context,
                "Settings",
                "lib/assets/images/Settings.svg",
                () => navigateTo(context, const ChangePasswordScreen()),
              ),
              _buildProfileMenu(
                context,
                "Help Center",
                "lib/assets/images/Question mark.svg",
                () => navigateTo(context, const HelpCenterScreen()),
              ),
              _buildProfileMenu(
                context,
                "Log Out",
                "lib/assets/images/Log out.svg",
                () => _showLogoutDialog(context),
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenu(
      BuildContext context, String text, String icon, VoidCallback press,
      {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isLogout
            ? Colors.red.withOpacity(0.1)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : const Color(0xFFF5F6F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            color: isLogout ? Colors.red : const Color(0xFF323345),
            width: 18,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.white,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isLogout ? Colors.red : Colors.white,
          size: 18,
        ),
        onTap: press,
      ),
    );
  }

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff323345),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Logout', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to log out?',
              style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    Token _token = Token();
    await _token.clearBearerToken();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String firstName;
  final String locationName;
  final VoidCallback onUpdateLocation;

  const ProfilePage({
    Key? key,
    required this.firstName,
    required this.locationName,
    required this.onUpdateLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/Profile Image.png"),
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFFF5F6F9),
                    ),
                    onPressed: () {},
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
              Positioned(
                left: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFFF5F6F9),
                    ),
                    onPressed: onUpdateLocation,
                    child: Icon(Icons.location_on, color: Color(0xFF323345)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          firstName,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          locationName,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }
}
