import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FirebaseUserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var logger = Logger();

  // Existing sign-up method
  Future<String?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Set display name
      await userCredential.user?.updateDisplayName(username);
      logger.i("Sign-Up successful: ${userCredential.user?.email}");
      return null;
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

  // Existing sign-in method
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i("Sign-In successful: ${userCredential.user?.email}");
      return null;
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
}
