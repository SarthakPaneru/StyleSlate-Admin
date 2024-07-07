// service_pie_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'modelservice.dart';

class ServicePieChart extends StatefulWidget {
  final int barberId;

  const ServicePieChart({super.key, required this.barberId});

  @override
  State<ServicePieChart> createState() => _ServicePieChartState();
}

class _ServicePieChartState extends State<ServicePieChart> {
  late Future<List<Service>> futureServices;

  @override
  void initState() {
    super.initState();
    futureServices = fetchServiceData(widget.barberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Usage Pie Chart'),
      ),
      body: FutureBuilder<List<Service>>(
        future: futureServices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<Service> services = snapshot.data!;
            return PieChart(
              PieChartData(
                sections: services.map((service) {
                  final color = Colors.primaries[
                      services.indexOf(service) % Colors.primaries.length];
                  return PieChartSectionData(
                    value: service.percentage,
                    title: '${service.percentage}%',
                    color: color,
                    radius: 100,
                    titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
