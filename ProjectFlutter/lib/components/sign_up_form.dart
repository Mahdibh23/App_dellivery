import 'package:flutter/material.dart';
import 'custom_surfix_icon.dart';
import 'form_error.dart';
import '../constants.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<String?> errors;
  final Function(String?) onSavedName;
  final Function(String?) onSavedEmail;
  final Function(String?) onSavedPassword;
  final Function(String?) onSavedConfirmPassword;
  final Function() onSubmit;

  const SignUpForm({
    Key? key,
    required this.formKey,
    required this.errors,
    required this.onSavedName,
    required this.onSavedEmail,
    required this.onSavedPassword,
    required this.onSavedConfirmPassword,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? password;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              onSaved: widget.onSavedName,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(widget.errors, error: kNamelNullError);
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(widget.errors, error: kNamelNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter your name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: widget.onSavedEmail,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(widget.errors, error: kEmailNullError);
                } else if (emailValidatorRegExp.hasMatch(value)) {
                  removeError(widget.errors, error: kInvalidEmailError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(widget.errors, error: kEmailNullError);
                  return "";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  addError(widget.errors, error: kInvalidEmailError);
                  return "";
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
              onSaved: widget.onSavedPassword,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(widget.errors, error: kPassNullError);
                } else if (value.length >= 8) {
                  removeError(widget.errors, error: kShortPassError);
                }
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(widget.errors, error: kPassNullError);
                  return "";
                } else if (value.length < 8) {
                  addError(widget.errors, error: kShortPassError);
                  return "";
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
            TextFormField(
              obscureText: true,
              onSaved: widget.onSavedConfirmPassword,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(widget.errors, error: kPassNullError);
                } else if (password == value) {
                  removeError(widget.errors, error: kMatchPassError);
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(widget.errors, error: kPassNullError);
                  return "";
                } else if (password != value) {
                  addError(widget.errors, error: kMatchPassError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                hintText: "Re-enter your password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            ),
            FormError(errors: widget.errors),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onSubmit,
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  void addError(List<String?> errors, {required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError(List<String?> errors, {required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
}
