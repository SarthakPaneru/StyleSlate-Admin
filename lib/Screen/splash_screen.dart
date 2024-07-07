import 'package:barberside/Screen/login.dart';
import 'package:barberside/Screen/mainscreen.dart';
import 'package:barberside/auth/token.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //check login status

    Future.delayed(const Duration(seconds: 2), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    String? token = await Token().retrieveBearerToken();
    if (token != null) {
      openDashBoard();
    } else {
      openLogin();
    }
  }

  void openDashBoard() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  void openLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('lib/assets/OIG2.jpeg')),
    );
  }
}
