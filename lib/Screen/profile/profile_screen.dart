import 'package:flutter/material.dart';

import 'body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff323345),
      body: Body(),
    );
  }
}
