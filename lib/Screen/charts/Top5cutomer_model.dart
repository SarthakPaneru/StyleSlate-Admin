class CustomerCategory {
  final int categoryCount;
  final String lastName;
  final String firstName;
  final int customerId;
  final String category;

  CustomerCategory({
    required this.categoryCount,
    required this.lastName,
    required this.firstName,
    required this.customerId,
    required this.category,
  });

  factory CustomerCategory.fromJson(Map<String, dynamic> json) {
    return CustomerCategory(
      categoryCount: json['category_count'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      customerId: json['customer_id'],
      category: json['category'],
    );
  }

  static List<CustomerCategory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerCategory.fromJson(json)).toList();
  }
}
