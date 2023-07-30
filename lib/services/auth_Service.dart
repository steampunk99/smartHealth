import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_health/models/user_role.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.ref().child('users');

  //sign up with email and password
  Future<String?> signUpWithEmailAndPassword(String email, String password,
      String fullName, String phoneNumber, UserRole role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Store the user role in Firebase metadata
        await user.updateDisplayName(role.toString());

        // Store additional user details in Firebase Realtime Database
        await _userRef.child(user.uid).set({
          'fullName': fullName,
          'role': role.toString().split('.').last,
          'phoneNumber': phoneNumber
        });
      }
      return user?.uid;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  //Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

// Sign in with email and password
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        return user.uid;
      }
    } catch (e) {
      print('Error during login: $e');
      return ''; // Return an empty string or a default value on error
    }
  }

  //call user role
  Future<UserRole> getUserRole() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DataSnapshot snapshot =
            await _userRef.child(user.uid).once() as DataSnapshot;
        Map<String, dynamic>? userData =
            snapshot.value as Map<String, dynamic>?;
        if (userData != null && userData['role'] != null) {
          return UserRole.values
              .firstWhere((role) => role.toString() == userData['role']);
        }
      }
      throw Exception('User not logged or role is not set');
    } catch (e) {
      throw Exception(e);
    }
  }
}
