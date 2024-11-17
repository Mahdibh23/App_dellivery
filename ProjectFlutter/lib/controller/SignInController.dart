import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/keyboard.dart';
import '../services/AuthService.dart';
import '../models/User.dart';
import '../screens/init_Screen.dart';

class SignInController {
  final ValueNotifier<List<String>> errors = ValueNotifier<List<String>>([]);
  User? currentUser;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/login');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        KeyboardUtil.hideKeyboard(context);
        await AuthService.saveToken(responseBody['token']);
        currentUser = User.fromJson(responseBody['user']);

        Navigator.pushNamedAndRemoveUntil(
          context,
          InitScreen.routeName,
          (route) => false,
          arguments: currentUser,
        );
      } else {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody.containsKey('error')) {
          errors.value = [...errors.value, responseBody['error']];
        } else {
          errors.value = [...errors.value, 'An unknown error occurred'];
        }
      }
    } catch (error) {
      errors.value = [...errors.value, 'Failed to connect to the server'];
    }
  }

  void addError({required String error}) {
    if (!errors.value.contains(error)) {
      errors.value = [...errors.value, error];
    }
  }

  void removeError({required String error}) {
    if (errors.value.contains(error)) {
      errors.value = errors.value.where((e) => e != error).toList();
    }
  }
}
