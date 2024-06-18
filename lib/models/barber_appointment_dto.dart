import 'dart:ffi';

class BarberAppointmentDto {
  final int id;
  final int barberId;
  final int customerId;
  final String serviceName;
  final String status;
  final int bookingStart;
  final int bookingEnd;

  BarberAppointmentDto({required this.id, required this.barberId, required this.customerId, required this.serviceName, required this.status, required this.bookingStart, required this.bookingEnd});

  BarberAppointmentDto.fromMap(Map map)
      : this(
            id: map['id'],
            barberId: map['barberId'],
            customerId: map['customerId'],
            serviceName: map['serviceName'],
            status: map['status'],
            bookingStart: map['bookingStart'],
            bookingEnd: map['bookingEnd']
            );

  Map<String, dynamic> asMap() => {
        'id': id,
        'barberId': barberId,
        'customerId': customerId,
        'serviceName': serviceName,
        'status': status,
        'bookingStart': bookingStart,
        'bookingEnd': bookingEnd
      };
}
