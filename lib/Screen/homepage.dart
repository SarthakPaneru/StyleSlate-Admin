import 'package:barberside/Screen/charts/piechart/piechart.dart';
import 'package:barberside/Screen/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:barberside/Widgets/category.dart';
import 'package:barberside/auth/category_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.id});
  final int id;

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

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff323345),
        body: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05),
          child: ListView(
            children: [
              CategorySection(categories: categories),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Analytics Section",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenHeight * 0.02,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CustomCard(
                      imagePath: 'lib/assets/piechart.jpg',
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.45,
                      onTap: () => _navigateToScreen(
                        context,
                        ServicePieChart(
                          barberId: widget.id,
                        ),
                      ),
                    ),
                    CustomCard(
                      imagePath: 'lib/assets/bar.jpg',
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.45,
                      onTap: () => _navigateToScreen(
                        context,
                        ServicePieChart(
                          barberId: widget.id,
                        ),
                      ),
                    ),
                    CustomCard(
                      imagePath: 'lib/assets/line.jpg',
                      height: screenHeight * 0.22,
                      width: screenWidth * 0.43,
                      onTap: () => _navigateToScreen(
                        context,
                        ServicePieChart(
                          barberId: widget.id,
                        ),
                      ),
                    ),
                    CustomCard(
                      imagePath: 'lib/assets/bubb.jpg',
                      height: screenHeight * 0.22,
                      width: screenWidth * 0.43,
                      onTap: () => _navigateToScreen(
                        context,
                        ServicePieChart(
                          barberId: widget.id,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
