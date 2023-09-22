import 'package:flutter/material.dart';
import '/Widgets/appbar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            title: 'Homepage',
            onpressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
