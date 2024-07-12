import 'package:barberside/Screen/addservice/modalsheet.dart';
import 'package:barberside/Screen/charts/Top5cutomer_model.dart';
// import 'package:barberside/Screen/charts/accordion_mode.dart';
import 'package:barberside/Screen/charts/bargraph/bargraph.dart';
import 'package:barberside/Screen/charts/piechart/piechart.dart';
import 'package:barberside/Screen/custom_card.dart';

import 'package:barberside/Widgets/category.dart';
import 'package:barberside/auth/category_model.dart';
import 'package:barberside/config/api_requests.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.id});
  final int id;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CategoryModel> categories = [];
  List<CustomerCategory> customerCategories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
    _fetchCategories();
  }

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
  }

  Future<void> _fetchCategories() async {
    final ApiRequests apiRequests = ApiRequests();
    try {
      customerCategories = await apiRequests.fetchCustomerCategories(widget.id);
    } catch (error) {
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff323345),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05),
            child: Column(
              children: [
                CategorySection(categories: categories),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Analytics Section",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        height: 40,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () => showAddServiceModal(context),
                          child: const Text(
                            'Add Service',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: screenWidth * 0.02,
                    mainAxisSpacing: screenHeight * 0.02,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CustomCard(
                        title: 'Popular Category',
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CategoryPieChart(
                                barberId: widget.id,
                                radius: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomCard(
                        title: 'Popular Service',
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ServicePieChart(
                                barberId: widget.id,
                                radius: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (customerCategories.isEmpty)
                        Container(
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.9,
                          alignment: Alignment.center,
                          child: const Text(
                            'No customer categories data available.',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      else
                        CustomCard(
                          title: 'Top Customer By Categories',
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.9,
                          child: ListView.builder(
                            itemCount: customerCategories.length,
                            itemBuilder: (context, index) {
                              final category = customerCategories[index];
                              return Card(
                                color: const Color(0xff454656),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${category.firstName} ${category.lastName}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Category: ${category.category}',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Category Count: ${category.categoryCount}',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
