import 'package:barberside/Screen/splash_screen.dart';
// ignore_for_file: avoid_print

import 'package:barberside/Screen/mainscreen.dart';
import 'package:barberside/config/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const Mainpage(),
  );
}

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool isLoggedIn = false;

  final ApiRequests _apiRequests = ApiRequests();
  @override
  void initState() {
    super.initState();
    isTokenValid();
  }

  Future<void> isTokenValid() async {
    http.Response response = await _apiRequests.getLoggedInUserEmail();
    if (response.statusCode == 200) {
      setState(() {
        isLoggedIn = true;
        print("Is logged In:");
        print(isLoggedIn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
