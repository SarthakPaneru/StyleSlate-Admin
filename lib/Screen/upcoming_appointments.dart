import 'dart:convert';

import 'package:barberside/config/api_requests.dart';
import 'package:barberside/models/barber_appointment_dto.dart';
import 'package:flutter/material.dart';
import 'appointment_details.dart';
import 'package:http/http.dart' as http;

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({super.key, required this.id});

  final int id;

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  final ApiRequests _apiRequests = ApiRequests();
  late List<BarberAppointmentDto> barberAppointment;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarberUpcomingAppointment();
  }

  Future<void> getBarberUpcomingAppointment() async {
    http.Response response =
        await _apiRequests.getBarberAppointment(widget.id, 'upcoming');

    final data = jsonDecode(response.body) as List;
    List<BarberAppointmentDto> dto =
        data.map((item) => BarberAppointmentDto.fromMap(item)).toList();
    setState(() {
      barberAppointment = dto;
      print('Return array length: ${barberAppointment.length}');
      print(barberAppointment.length);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (barberAppointment.isEmpty) {
      return const Center(
        child: Text(
          'No Appointment available',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return ListView.builder(
      itemCount: barberAppointment.length,
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
              barberAppointment[index].serviceName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${barberAppointment[index].bookingStart} ',
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
