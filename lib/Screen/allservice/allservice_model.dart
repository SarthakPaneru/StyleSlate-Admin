class Service {
  int id;
  String serviceName;
  String fee;
  String serviceTimeInMinutes;
  String category;

  Service({
    required this.id,
    required this.serviceName,
    required this.fee,
    required this.serviceTimeInMinutes,
    required this.category,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['serviceName'],
      fee: json['fee'],
      serviceTimeInMinutes: json['serviceTimeInMinutes'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'fee': fee,
      'serviceTimeInMinutes': serviceTimeInMinutes,
      'category': category,
    };
  }
}
