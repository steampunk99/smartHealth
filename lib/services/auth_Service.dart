import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_health/models/user_role.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref().child('users');

  //sign up with email and password
  Future<String?> signUpWithEmailAndPassword(
      String email, String password,DateTime dateOfBirth, String fullName, UserRole role) async {
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
        'role': role.toString(),
        'dateOfBirth':dateOfBirth.toIso8601String()
      });
    }
      return user?.uid;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

// Sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if(user != null){
        return user.uid;
      }
      
    } catch (e) {
      print('Error during login: $e');
      return ''; // Return an empty string or a default value on error
    }
  }

  //call user role
  Future<UserRole> getUserRole() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? roleName = user.displayName;
      if(roleName != null) {
        return UserRole.values.firstWhere((role) => role.toString()==roleName, orElse: ()=>null)
      }
    }
    return null;
  }

  //Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
