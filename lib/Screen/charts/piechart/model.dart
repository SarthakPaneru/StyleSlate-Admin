class Category {
  final String name;
  final double percentage;
  final double appointmentCount;

  Category({
    required this.name,
    required this.percentage,
    required this.appointmentCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['category'],
      appointmentCount: json['appointment_count'].toDouble(),
      percentage: json['appointment_percentage'].toDouble(),
    );
  }
}
