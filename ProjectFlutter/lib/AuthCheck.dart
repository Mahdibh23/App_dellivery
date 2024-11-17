import 'package:flutter/material.dart';

import 'services/AuthService.dart';
import 'screens/home/home_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        }
      },
    );
  }
}
