import 'package:barberside/Screen/charts/accordion_mode.dart';
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
                        Center(child: CircularProgressIndicator())
                      else if (customerCategories.isEmpty)
                        Container(
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.9,
                          alignment: Alignment.center,
                          child: Text(
                            'No customer categories data available.',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      else
                        CustomCard(
                          title: 'Customer Categories',
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.9,
                          child: ListView.builder(
                            itemCount: customerCategories.length,
                            itemBuilder: (context, index) {
                              final category = customerCategories[index];
                              return ListTile(
                                title: Text(
                                  '${category.firstName} ${category.lastName}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Category: ${category.category}\n'
                                  'Category Count: ${category.categoryCount}\n'
                                  'Customer ID: ${category.customerId}',
                                  style: const TextStyle(color: Colors.white70),
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
