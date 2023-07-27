import 'package:flutter/material.dart';
import 'package:smart_health/models/user_role.dart';
import 'package:smart_health/screens/SignUp.dart';
import 'package:smart_health/screens/doctor_screen.dart';
import 'package:smart_health/screens/patient_screen.dart';
import 'package:smart_health/screens/pharmacist_screen.dart';
import 'package:smart_health/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    String? userId =
        await _authService.signInWithEmailAndPassword(email, password);

    if (userId != null) {
      //login successful, fetch the user role and navigate to the respective screen
      UserRole? userRole = await _authService.getUserRole();
      if (userRole != null) {
        _navigateToHomeScreen(userRole);
      } else {
        return null; //do nothing for now
      }
    }
  }

  void _navigateToHomeScreen(UserRole role) {
    switch (role) {
      case UserRole.patient:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientHomeScreen()));
        break;

      case UserRole.doctor:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DoctorHomeScreen()));
        break;

      case UserRole.pharmacist:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PharmacistHomeScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: _handleLogin, child: Text('Login')),
            SizedBox(
              height: 10,
            ),
          ]),
        ));
  }
}
