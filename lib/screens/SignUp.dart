import 'package:flutter/material.dart';
import 'package:smart_health/screens/doctor_screen.dart';
import 'package:smart_health/screens/patient_screen.dart';
import 'package:smart_health/screens/pharmacist_screen.dart';
import 'package:smart_health/services/auth_service.dart';
import 'package:smart_health/models/user_role.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final AuthService _authService = AuthService();

  UserRole _selectedUserRole = UserRole.patient;

  void _handleRegistration() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String fullName = _fullNameController.text.trim();

    UserRole role = _selectedUserRole ??
        UserRole.patient; //setting default for new registration

    String? userId = await _authService.signUpWithEmailAndPassword(
        email, password, fullName, role);

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
      appBar: AppBar(title: Text("Registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(hintText: 'Full Name'),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<UserRole>(
              value: _selectedUserRole,
              onChanged: (UserRole? newValue) {
                setState(() {
                  _selectedUserRole = newValue!;
                });
              },
              items: UserRole.values.map((UserRole role) {
                return DropdownMenuItem<UserRole>(
                  value: role,
                  child: Text(getRoleName(role)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _handleRegistration, child: Text('Register'))
          ],
        ),
      ),
    );
  }

  //User friendly display of user roles
  String getRoleName(UserRole role) {
    String roleName = role.toString().split('.').last;
    return roleName[0].toUpperCase() + roleName.substring(1);
  }
}
