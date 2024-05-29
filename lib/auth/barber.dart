import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Barber {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> storeBarberDetails(
      Map<String, dynamic> jsonResponseCustomer) async {
    try {
      final barberId = jsonResponseCustomer['id'];

      Map<String, dynamic> user = jsonResponseCustomer['user'];
      Map<String, dynamic> jsonResponseUser = jsonDecode(jsonEncode(user));
      final barberEmail = jsonResponseUser['email'];
      final userId = jsonResponseUser['id'];
      final firstName = jsonResponseUser['firstName'];
      final lastName = jsonResponseUser['lastName'];
      final phone = jsonResponseUser['phone'];

      await _storage.write(key: 'barberId', value: barberId.toString());
      await _storage.write(key: 'userId', value: userId.toString());
      await _storage.write(key: 'barberEmail', value: barberEmail.toString());
      await _storage.write(key: 'firstName', value: firstName.toString());
      await _storage.write(key: 'lastName', value: lastName.toString());
      await _storage.write(key: 'phone', value: phone.toString());
    } catch (e) {
      // Handle Error
      print('Error storing customer details: $e');
    }
  }

  Future<String?> retrieveBarberId() async {
    try {
      final barberId = await _storage.read(key: 'barberId');
      // You can add additional validation here if needed.
      if (barberId != null) {
        return barberId;
      } else {
        // Handle the case where barberId is not found in storage.
        print('Barber Id not found in storage');
        return null;
      }
    } catch (e) {
      // Handle any exceptions that may occur during retrieval.
      print('Error retrieving barber ID: $e');
      return null;
    }
  }

  Future<String?> retrieveCustomerEmail() async {
    return await _storage.read(key: 'barberEmail');
  }

  Future<String?> retrieveFirstName() async {
    return await _storage.read(key: 'firstName');
  }

  Future<String?> retrieveLastName() async {
    return await _storage.read(key: 'lastName');
  }

  Future<String?> retrieveUserId() async {
    return await _storage.read(key: 'userId');
  }

  Future<String?> retrievePhone() async {
    return await _storage.read(key: 'phone');
  }
}
