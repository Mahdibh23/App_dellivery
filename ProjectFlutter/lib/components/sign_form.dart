import 'package:flutter/material.dart';
import '../components/custom_surfix_icon.dart';
import '../components/form_error.dart';
import '../constants.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../controller/SignInController.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final SignInController _signInController = SignInController();

  @override
  void initState() {
    super.initState();
    _signInController.errors.addListener(() {
      setState(
          () {}); // Met à jour l'interface utilisateur lorsque les erreurs changent
    });
  }

  @override
  void dispose() {
    _signInController.errors.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _signInController.removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                _signInController.removeError(error: kInvalidEmailError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                _signInController.addError(error: kEmailNullError);
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                _signInController.addError(error: kInvalidEmailError);
                return kInvalidEmailError;
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _signInController.removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                _signInController.removeError(error: kShortPassError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                _signInController.addError(error: kPassNullError);
                return kPassNullError;
              } else if (value.length < 8) {
                _signInController.addError(error: kShortPassError);
                return kShortPassError;
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: _signInController.errors.value),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!
                    .save(); // Sauvegarde des données du formulaire
                _signInController.login(
                  email: email!,
                  password: password!,
                  context: context,
                );
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
