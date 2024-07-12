class ServiceData {
  final String serviceName;
  final double appointmentPercentage;
  final int appointmentCount;

  ServiceData({
    required this.serviceName,
    required this.appointmentPercentage,
    required this.appointmentCount,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      serviceName: json['service_name'],
      appointmentPercentage: json['appointmentPercentage'].toDouble(),
      appointmentCount: json['appointmentCount'],
    );
  }
}
