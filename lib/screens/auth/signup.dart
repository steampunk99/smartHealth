import 'package:flutter/material.dart';
import 'package:smart_health/screens/auth/login.dart';
import 'package:smart_health/screens/doctor/doctor_screen.dart';
import 'package:smart_health/screens/patient/patient_screen.dart';
import 'package:smart_health/screens/pharmacist/pharmacist_screen.dart';
import 'package:smart_health/services/auth_service.dart';
import 'package:smart_health/models/user_role.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final AuthService _authService = AuthService();

  Color bg = Color(0xFF0062F8);

  UserRole _selectedUserRole = UserRole.patient;
  String? _phoneNumber;

  void _handleRegistration() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String fullName = _fullNameController.text.trim();
    String phoneNumber = _phoneNumber?.trim() ?? "";

    UserRole role = _selectedUserRole ??
        UserRole.patient; //setting default for new registration

    String? userId = await _authService.signUpWithEmailAndPassword(
        email, password, fullName, phoneNumber, role);

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),

            //Upper text -welcome
            Column(
              children: const [
                Text("CREATE YOUR ACCOUNT",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ibm')),
                Text(
                  "Join our community where health is priority",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),

            // Phone number field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InternationalPhoneNumberInput(
                inputDecoration: InputDecoration(
                    hintText: 'Phone Number',
                    fillColor: Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white))),
                onInputChanged: (PhoneNumber number) {
                  _phoneNumber = number.phoneNumber;
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                ),
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue:
                    PhoneNumber(isoCode: 'UG'), // Set initial country code here
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //Full name textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
            SizedBox(
              height: 10,
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
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
            SizedBox(
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
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white))),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //select account type
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButtonFormField<UserRole>(
                decoration: InputDecoration(
                    hintText: 'Select Account Type',
                    fillColor: Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white))),
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
            ),
            SizedBox(
              height: 80,
            ),

            //Register Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 0, 98, 248))),
                    onPressed: _handleRegistration,
                    child: const Text(
                      'CREATE ACCOUNT',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(fontSize: 15)),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 98, 248)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  //
  Widget _buildTextFieldWithLabel(
      String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,
            ),
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }

  //User friendly display of user roles
  String getRoleName(UserRole role) {
    String roleName = role.toString().split('.').last;
    return roleName[0].toUpperCase() + roleName.substring(1);
  }
}
