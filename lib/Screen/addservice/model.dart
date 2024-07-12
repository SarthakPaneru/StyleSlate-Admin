class ServiceModel {
  final String serviceName;
  final String fee;
  final String serviceTimeInMinutes;
  final String category;

  ServiceModel({
    required this.serviceName,
    required this.fee,
    required this.serviceTimeInMinutes,
    required this.category,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceName: json['serviceName'],
      fee: json['fee'],
      serviceTimeInMinutes: json['serviceTimeInMinutes'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'fee': fee,
      'serviceTimeInMinutes': serviceTimeInMinutes,
      'category': category,
    };
  }
}
