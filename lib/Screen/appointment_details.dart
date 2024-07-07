import 'package:flutter/material.dart';

class AppointmentDetails extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetails({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointment ID: $appointmentId',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Customer Name: Aayush dahal',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Service: Haircut',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Date: 2024-05-29',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Time: 3:00 PM',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
