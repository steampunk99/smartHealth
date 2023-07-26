import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:smart_health/services/auth_Service.dart';
import 'package:smart_health/models/user_role.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final AuthService _authService = AuthService();

  void _handleRegistration() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String fullName = _fullNameController.text.trim();
    DateTime dateOfBirth = DateTime.parse(_dateOfBirthController.text.trim());

    UserRole role = UserRole.patient; //setting default for new registration

    String? userId = await _authService.signUpWithEmailAndPassword(
        email, password, dateOfBirth, fullName, role);

    if (userId != null) {
      //Registration successfull, navigate to the respective home screen
      _navigateToHomeScreen(role);
    } else {
      //Registration failed
      print("Sign Up failed");
    }
  }

  void _navigateToHomeScreen(UserRole role) {
    switch (role) {
      case UserRole.patient:
        Navigator.pushReplacement(context, '/patient_home');
        break;

      case UserRole.doctor:
        Navigator.pushReplacement(context, '/doctor_home');
        break;

      case UserRole.pharmacist:
        Navigator.pushReplacement(context, '/pharmacist_home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
