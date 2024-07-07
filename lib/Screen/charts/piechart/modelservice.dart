import 'dart:convert';
import 'package:http/http.dart' as http;

// modelservice.dart
class Service {
  final String name;
  final double percentage;

  Service({required this.name, required this.percentage});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      percentage: json['percentage'].toDouble(),
    );
  }
}

Future<List<Service>> fetchServiceData(int barberId) async {
  final response = await http
      .get(Uri.parse('https://api.example.com/services?barberId=$barberId'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((service) => Service.fromJson(service)).toList();
  } else {
    throw Exception('Failed to load service data');
  }
}
