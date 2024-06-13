import 'package:barberside/Screen/booking_card.dart';
import 'package:barberside/Widgets/category.dart';
import 'package:barberside/auth/category_model.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CategoryModel> categories = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
  }

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          CategorySection(categories: categories),
          const SizedBox(height: 20),
          const SizedBox(
            height: 200, // Adjust this height based on your requirement
            child: BookingCard(
              
            ),
          ),
        ],
      ),
    );
  }
}
