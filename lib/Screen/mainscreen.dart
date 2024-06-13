import 'package:barberside/Screen/homepage.dart';
import 'package:barberside/Screen/profile/profile.dart';
import 'package:barberside/Screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'upcoming_appointments.dart';
import 'completed_appointments.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Homepage(),
    const UpcomingAppointments(),
    const CompletedAppointments(),
    const ProfileScreen()
  ];

  void _onItemTapped(int indexx) {
    setState(() {
      _selectedIndex = indexx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 153, 210, 236),
        title: const Text(
          'Booking Details',
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.schedule,
            ),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
            ),
            label: 'Completed',
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color.fromARGB(255, 214, 133, 133),
        onTap: _onItemTapped,
      ),
    );
  }
}
