import 'package:flutter/material.dart';
import 'appointment_details.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, 
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            leading: const Icon(
              Icons.event,
              color: Colors.blue,
            ),
            title: Text(
              'Appointment $index',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Details of Appointment $index',
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDetails(
                    appointmentId: 'ID $index',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
