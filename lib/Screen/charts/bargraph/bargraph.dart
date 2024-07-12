import 'package:barberside/Screen/charts/bargraph/model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:barberside/config/api_requests.dart';

class ServicePieChart extends StatefulWidget {
  final double radius;
  final int barberId;

  const ServicePieChart(
      {super.key, required this.barberId, required this.radius});

  @override
  State<ServicePieChart> createState() => _ServicePieChartState();
}

class _ServicePieChartState extends State<ServicePieChart> {
  late Future<List<ServiceData>> futureServiceData;
  final ApiRequests _apiRequests = ApiRequests();
  int? _touchedIndex;

  @override
  void initState() {
    super.initState();
    futureServiceData = _apiRequests.fetchServiceData(widget.barberId);
  }

  void _onSectionTapped(int index, ServiceData serviceData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(serviceData.serviceName),
          content: Text('Percentage: ${serviceData.appointmentPercentage}%'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ServiceData>>(
      future: futureServiceData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          List<ServiceData> serviceDataList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                      if (event is FlTapUpEvent) {
                        _onSectionTapped(
                          _touchedIndex!,
                          serviceDataList[_touchedIndex!],
                        );
                      }
                    });
                  },
                ),
                sections: serviceDataList.asMap().entries.map((entry) {
                  int index = entry.key;
                  ServiceData serviceData = entry.value;
                  final isTouched = index == _touchedIndex;
                  final color = index % 2 == 0
                      ? const Color(0xff9DCEFF)
                      : const Color(0xffEEA4CE);
                  ;
                  final double fontSize = isTouched ? 18 : 14;
                  final double radius = isTouched ? 110 : 100;

                  return PieChartSectionData(
                    value: serviceData.appointmentPercentage,
                    title:
                        '${serviceData.serviceName}\n${serviceData.appointmentPercentage}%',
                    color: color,
                    radius: radius,
                    titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }).toList(),
                borderData: FlBorderData(show: false),
                sectionsSpace: 4,
                centerSpaceRadius: 20,
              ),
            ),
          );
        }
      },
    );
  }
}
