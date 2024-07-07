import 'package:barberside/Screen/login.dart';
import 'package:barberside/auth/token.dart';
import 'package:flutter/material.dart';

import 'Myaccount.dart';
import 'changepassword.dart';
import 'helpcenterscreen.dart';
import 'profile.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePage(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "lib/assets/User Icon.svg",
            press: () => {navigateTOMyaccount(context)},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "lib/assets/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "lib/assets/Settings.svg",
            press: () => {navigateTOChangePassword(context)},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "lib/assets/Question mark.svg",
            press: () => {navigateTOHelpcenter(context)},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "lib/assets/Log out.svg",
            press: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text('Are you sure.'),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () async {
                          // Perform logout action
                          await _logout(context);
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void navigateTOChangePassword(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
  }

  void navigateTOHelpcenter(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HelpCenterScreen()));
  }

  void navigateTOMyaccount(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyAccountScreen()));
  }

  Future<void> _logout(BuildContext context) async {
    // Clear the stored token
    Token _token = Token();
    await _token.clearBearerToken();

    // Navigate to the Login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false,
    );
  }
}
