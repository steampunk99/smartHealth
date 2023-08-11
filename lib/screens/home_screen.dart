import 'package:flutter/material.dart';
import 'package:smart_health/services/auth_service.dart';
import 'package:smart_health/models/user_role.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthService _authService = AuthService();

  void _getUserRole() async {
    UserRole? userRole = await _authService.getUserRole();
    if (userRole == UserRole.patient) {
    } else if (userRole == UserRole.pharmacist) {
    } else if (userRole == UserRole.doctor) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _getUserRole();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynaxo Health"),
      ),
      body: const Center(child: Text('Loading.. ')),
      //.........
    );
  }
}
