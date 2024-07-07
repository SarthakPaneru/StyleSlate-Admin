// ignore_for_file: avoid_print

import 'package:barberside/Screen/mainscreen.dart';
import 'package:barberside/config/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '/Widgets/colors.dart';
import '/Screen/login.dart';

void main() {
  runApp(const MaterialApp(
    home: Mainpage(),
  ));
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
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          centerTitle: true,
          backgroundColor: PrimaryColors.primarybrown,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              const SizedBox(height: 75),
              Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset(
                  'lib/assets/OIG2.jpeg',
                  height: 170,
                  width: 300,
                ),
              ),
              const Text(
                'कपाल काट्टने होईनत ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 45),
              FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: PrimaryColors.primarybrown,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      if (isLoggedIn) {
                        return const MainScreen();
                      }
                      return const Login();
                    },
                  ));
                },
                child: const Icon(Icons.arrow_forward_outlined, size: 28),
              ),
              const SizedBox(height: 10),
              const Text(
                "Let's Explore",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
