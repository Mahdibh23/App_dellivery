import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/components/sign_up_form.dart';
import 'dart:convert'; // For JSON encoding/decoding
import '../screens/init_Screen.dart';
import '../services/AuthService.dart';
import '/models/User.dart';

class SignUpController extends StatefulWidget {
  const SignUpController({super.key});

  @override
  _SignUpControllerState createState() => _SignUpControllerState();
}

class _SignUpControllerState extends State<SignUpController> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  String? name;
  bool remember = false;
  User? currentUser;

  final List<String?> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> signUp() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/register');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name!,
          'email': email!,
          'password': password!,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        await AuthService.saveToken(responseBody['token']);
        setState(() {
          currentUser = User.fromJson(responseBody['user']);
        });
        Navigator.pushNamed(
          context,
          InitScreen.routeName,
          arguments: currentUser,
        );
      } else {
        final responseBody = json.decode(response.body);
        if (responseBody.containsKey('email')) {
          addError(error: responseBody['email'][0]);
        } else if (responseBody.containsKey('password')) {
          addError(error: responseBody['password'][0]);
        } else if (responseBody.containsKey('name')) {
          addError(error: responseBody['name'][0]);
        } else {
          addError(error: 'An unknown error occurred');
        }
      }
    } catch (error) {
      addError(error: 'Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignUpForm(
      formKey: _formKey,
      errors: errors,
      onSavedName: (newValue) => name = newValue,
      onSavedEmail: (newValue) => email = newValue,
      onSavedPassword: (newValue) => password = newValue,
      onSavedConfirmPassword: (newValue) => confirmPassword = newValue,
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          signUp(); // Call the signUp function
        }
      },
    );
  }
}
