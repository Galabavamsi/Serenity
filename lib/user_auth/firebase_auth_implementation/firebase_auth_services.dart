import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';


class FirebaseUserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var logger = Logger();

  // Sign-Up Method with Firebase Auth and Firestore
  Future<String?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Set the username (display name) in Firebase Auth
      await userCredential.user?.updateDisplayName(username);

      // Add user data to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });

      logger.i("Sign-Up successful: ${userCredential.user?.email}");
      return null; // Null indicates success
    } on FirebaseAuthException catch (e) {
      logger.e("Error in sign-up: $e");
      if (e.code == 'email-already-in-use') {
        return 'The email is already in use by another account.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is invalid.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak.';
      }
      return 'An error occurred. Please try again later.';
    }
  }

  // Sign-In Method with Firestore User Data Update
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Update or create the user document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'lastSignIn': FieldValue.serverTimestamp(), // Update sign-in timestamp
        }, SetOptions(merge: true)); // Use merge to update only specified fields

        logger.i("Sign-In successful and user data updated in Firestore: ${user.email}");
      }

      return null; // Null indicates success
    } on FirebaseAuthException catch (e) {
      logger.e("Error in sign-in: $e");
      if (e.code == 'user-not-found') {
        return 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password. Please try again.';
      }
      return 'An error occurred. Please try again later.';
    }
  }

  // Update Username
  Future<String?> updateUsername(String newUsername) async {
    try {
      await _auth.currentUser?.updateDisplayName(newUsername);
      await _auth.currentUser?.reload();

      // Update username in Firestore
      await _firestore.collection('users').doc(_auth.currentUser?.uid).update({
        'username': newUsername,
      });

      logger.i("Username updated successfully to: $newUsername");
      return null;
    } on FirebaseAuthException catch (e) {
      logger.e("Error updating username: $e");
      return 'Could not update username. Please try again later.';
    }
  }

  // Update Password
  Future<String?> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      logger.i("Password updated successfully");
      return null;
    } on FirebaseAuthException catch (e) {
      logger.e("Error updating password: $e");
      if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else if (e.code == 'requires-recent-login') {
        return 'Please sign in again to change your password.';
      }
      return 'Could not update password. Please try again later.';
    }
  }

  // Delete Account
  Future<String?> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
      await _firestore.collection('users').doc(_auth.currentUser?.uid).delete();
      logger.i("Account deleted successfully");
      return null;
    } on FirebaseAuthException catch (e) {
      logger.e("Error deleting account: $e");
      if (e.code == 'requires-recent-login') {
        return 'Please sign in again to delete your account.';
      }
      return 'Could not delete account. Please try again later.';
    }
  }

  // Fetch current username from Firestore
  Future<String?> getCurrentUsername() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Fetch the username from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return userDoc['username'] ?? "No username set";
        }
        return "No username set"; // If username is not found
      }
      return null; // If no user is signed in
    } catch (e) {
      logger.e("Error fetching current username: $e");
      return null; // Handle errors gracefully
    }
  }
}
