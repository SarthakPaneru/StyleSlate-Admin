import 'package:flutter/material.dart';

import 'allservice_model.dart';

class CustomCard extends StatelessWidget {
  final Service service;

  const CustomCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(62, 0, 0, 0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service: ${service.serviceName}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Fee: ${service.fee}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Time: ${service.serviceTimeInMinutes} min',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Category: ${service.category}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
