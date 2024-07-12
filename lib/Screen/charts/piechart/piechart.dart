import 'package:barberside/Screen/charts/piechart/model.dart';
import 'package:barberside/config/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryPieChart extends StatelessWidget {
  final int barberId;
  final double radius; // Accept radius to adjust size within card

  const CategoryPieChart({
    super.key,
    required this.barberId,
    this.radius = 60, // Default radius value reduced
  });

  Future<List<Category>> fetchCategories() async {
    final ApiRequests apiRequests = ApiRequests();
    return await apiRequests.fetchCategoryData(barberId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          List<Category> categories = snapshot.data!;
          return PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {},
              ),
              sections: categories.asMap().entries.map((entry) {
                int index = entry.key;
                Category category = entry.value;
                final color = index % 2 == 0
                    ? const Color(0xff9DCEFF)
                    : const Color(0xffEEA4CE);

                return PieChartSectionData(
                  value: category.percentage,
                  title: '${category.name}\n${category.percentage}%',
                  color: color,
                  radius: radius,
                  titleStyle: const TextStyle(
                    fontSize: 14, // Adjust font size to match chart size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              }).toList(),
              borderData: FlBorderData(show: false),
              sectionsSpace: 4,
              centerSpaceRadius: 20,
            ),
          );
        }
      },
    );
  }
}
