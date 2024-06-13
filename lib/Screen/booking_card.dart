import 'package:flutter/material.dart';
import 'appointment_details.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8, 
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
              'Haircut $index',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'Time : 3:00 PM ',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Accept',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10), // Spacing between text and button
                FloatingActionButton(
                  onPressed: () {
                    // Show a dialog when the button is pressed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Appointment'),
                          content: const Text('Do you want to accept this appointment?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Confirm the action and perform necessary steps
                                // ignore: avoid_print
                                print('Appointment $index accepted');
                                Navigator.of(context).pop(); // Close the dialog
                                // You can also add any additional functionality here
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  mini: true, // Use a smaller FAB
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.check,size: 20,),
                ),
              ],
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
