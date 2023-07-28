import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_health/screens/doctor/doctor_screen.dart';
import 'package:smart_health/screens/auth/login.dart';
import 'package:smart_health/screens/patient/patient_screen.dart';
import 'package:smart_health/screens/pharmacist/pharmacist_screen.dart';
import 'package:smart_health/screens/auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Health',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/register',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/patient-home': (context) => const PatientHomeScreen(),
        '/doctor-home': (context) => const DoctorHomeScreen(),
        '/pharmacist-home': (context) => const PharmacistHomeScreen(),
      },
    );
  }
}
