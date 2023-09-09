import 'package:flutter/material.dart';
import 'package:smart_health/models/user_role.dart';
import 'package:smart_health/screens/auth/signup.dart';
import 'package:smart_health/screens/doctor/doctor_screen.dart';
import 'package:smart_health/screens/patient/patient_screen.dart';
import 'package:smart_health/screens/pharmacist/pharmacist_screen.dart';
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
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //upper text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 150,
              ),
              Text(
                "WELCOME BACK",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sign In to see what's happening in the community.",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),

          const SizedBox(
            height: 30,
          ),
          //Email field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.grey[200],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.grey[200],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white))),
              obscureText: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 0, 98, 248))),
                  onPressed: _handleLogin,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  )),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?",
                  style: TextStyle(fontSize: 15)),
              TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen())),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 0, 98, 248)),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    ));
  }
}
