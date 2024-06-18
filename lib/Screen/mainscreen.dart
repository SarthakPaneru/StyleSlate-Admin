import 'package:barberside/Screen/homepage.dart';
import 'package:barberside/Screen/profile/profile_screen.dart';
import 'package:barberside/auth/barber.dart';
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
  int? barberId;
  Barber barber = Barber();

  @override
  void initState() {
    super.initState();
    getCustomerId();
  }

  void getCustomerId() async {
    String tempid = (await barber.retrieveBarberId())!;
    setState(() {
      barberId = int.parse(tempid);
      print('BarberId updated');
      print(barberId);
    });
  }

  List<Widget> _widgetOptions() {
    if (barberId == null) {
      return <Widget>[
        const Center(child: CircularProgressIndicator()),
        const Center(child: CircularProgressIndicator()),
        const Center(child: CircularProgressIndicator()),
        const Center(child: CircularProgressIndicator()),
      ];
    }
    print(barberId);
    return <Widget>[
      const Homepage(),
      UpcomingAppointments(id: barberId!),
      CompletedAppointments(id: barberId!,),
      const ProfileScreen()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 153, 210, 236),
        title: const Text('Booking Details'),
      ),
      body: Center(
        child: _widgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color.fromARGB(255, 214, 133, 133),
        onTap: _onItemTapped,
      ),
    );
  }
}
