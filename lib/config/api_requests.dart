import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../auth/customer.dart';
import 'api_service.dart';
import 'app_constants.dart';

class ApiRequests {
  final ApiService _apiService = ApiService();

  // Get Email of currently logged in user
  Future<http.Response> getLoggedInUserEmail() async {
    http.Response response = await _apiService
        .get('${ApiConstants.usersEndpoint}/get-logged-in-user');
    print('Logged in users status ${response.statusCode}');
    if (response.statusCode == 200) {
      // Successful login
      return response;
    } else {
      print('Login failed with status code: ${response.statusCode}');
      throw Future.error(
          'Login failed with status code: ${response.statusCode}');
    }
  }

  Future<http.Response> getLoggedInBarber() async {
    http.Response response = await _apiService
        .get('${ApiConstants.barbersEndpoint}/get-logged-in-user');
    print('Logged in users stattus ${response.statusCode}');
    if (response.statusCode == 200) {
      // Successful login
      return response;
    } else {
      print('Login failed with status code: ${response.statusCode}');
      throw Future.error(
          'Login failed with status code: ${response.statusCode}');
    }
  }

  // Register the user
  Future<http.Response> register(String email, String password,
      String confirmPassword, String firstName, String lastName) async {
    final payload = {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName
    };
    final jsonPayload = jsonEncode(payload);

    http.Response response = await _apiService.post(
        '${ApiConstants.authEndpoint}/register', jsonPayload);

    return response;
  }

  // List all barbers
  Future<http.Response> getBarbers() async {
    http.Response response =
        await _apiService.get('${ApiConstants.barbersEndpoint}/get-all');
    return response;
  }

  // Create Appointment
  Future<http.Response> createAppointment(
      int bookingStart, int bookingEnd, int barberId, int serviceId) async {
    final payload = {
      'bookingStart': bookingStart,
      'bookingEnd': bookingEnd,
      'barberId': barberId,
      'servicesIds': [serviceId.toString()]
    };

    print("HEREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    final jsonPayload = jsonEncode(payload);
    http.Response response = await _apiService.post(
        '${ApiConstants.appointmentEndpoint}/save', jsonPayload);
    return response;
  }

  // upload user image
  Future<http.Response> uploadImage(File file) async {
    http.Response response = await _apiService.postImg(
        '${ApiConstants.usersEndpoint}/image/save', file);
    return response;
  }

  // get Appointments
  Future<http.Response> getAppointments(String status) async {
    Customer customer = Customer();
    final customerId = await customer.retrieveCustomerId();
    print("Customer Id: ${customerId.toString()}");
    http.Response response = await _apiService.get(
        '${ApiConstants.appointmentEndpoint}/get/barber/${customerId.toString()}?status=$status');
    return response;
  }

  Future<http.Response> sendLocationData(
      double latitude, double longitude) async {
    final String url = 'https://your_api_endpoint';
    final Map<String, dynamic> body = {
      'latitude': latitude,
      'longitude': longitude,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    return response;
  }

  Future<String> retrieveImageUrl() async {
    Customer customer = Customer();
    final userId = await customer.retrieveUserId();
    return '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId/get-image';
    // .toString();
  }

  String retrieveImageUrlFromUserId(int userId) {
    return '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId/get-image';
    // .toString();
  }

  Future<http.Response> getNearestBarber(
      double latitude, double longitude) async {
    print('API REQUEST: $latitude');

    return await _apiService.get(
        '${ApiConstants.barbersEndpoint}/get/nearest?latitude=${latitude.toDouble()}&longitude=${longitude.toDouble()}');
  }

  Future<http.Response> getBarber(int barberId) async {
    return await _apiService
        .get('${ApiConstants.barbersEndpoint}/get/$barberId');
  }

  // Future<http.Response> updatePassword(String currentPassword,
  //     String newPassword, String confirmPassword) async {
  //   String? email = await Customer().retrieveCustomerEmail();
  //   final payload = {
  //     'email': email!,
  //     'currentPassword': currentPassword,
  //     'newPassword': newPassword,
  //     'confirmNewPassword': confirmPassword
  //   };
  //   final jsonPayload = jsonEncode(payload);
  //   return await _apiService.put(
  //       '${ApiConstants.usersEndpoint}/update-password', jsonPayload);
  // }

  // Future<http.Response> forgotPassword(String email) async {
  //   final payload = {'email': email};
  //   final jsonPayload = jsonEncode(payload);
  //   return await _apiService.post(
  //       '${ApiConstants.authEndpoint}/forgot-password?email=$email',
  //       jsonPayload);
  // }

  // Future<http.Response> forgotChangePassword(String email, String newPassword,
  //     String confirmPassword, String otp) async {
  //   final payload = {
  //     'email': email,
  //     'newPassword': newPassword,
  //     'confirmNewPassword': confirmPassword,
  //     'otp': otp
  //   };
  //   final jsonPayload = jsonEncode(payload);
  //   return await _apiService.put(
  //       '${ApiConstants.authEndpoint}/confirm-forgot-password', jsonPayload);
  // }

  Future<http.Response> getBarberAppointment(
      int barberId, String status) async {
    return await _apiService.get(
        '${ApiConstants.appointmentEndpoint}/get/barber/$barberId?status=$status');
  }
}
