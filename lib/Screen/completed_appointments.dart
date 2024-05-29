import 'package:flutter/material.dart';
import 'appointment_details.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with actual data count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: const Icon(Icons.event_available, color: Colors.green),
            title: Text(
              'Completed Appointment $index',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Details of Completed Appointment $index',
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AppointmentDetails(appointmentId: 'ID $index')),
              );
            },
          ),
        );
      },
    );
  }
}
