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
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
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
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Update or create the user document in Firestore
        await _firestore.collection('users').doc(user.uid).set(
            {
              'uid': user.uid,
              'email': email,
              'lastSignIn': FieldValue.serverTimestamp(), // Update sign-in timestamp
            },
            SetOptions(merge: true)); // Use merge to update only specified fields

        logger.i("Sign-In successful and user data updated in Firestore: ${user.email}");
      }

      return null; // Null indicates success
    } on FirebaseAuthException catch (e) {
      logger.e("Error in sign-in: $e");

      // Handle different FirebaseAuthException error codes
      if (e.code == 'user-not-found') {
        return 'User does not exist. Please check your email or sign up.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password. Please try again.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is invalid. Please check the format and try again.';
      } else if (e.code == 'invalid-credential') {
        return 'The supplied auth credential is incorrect or malformed. Please check the email/password and try again.';
      } else {
        return 'An error occurred. Please try again later.';
      }
    }
  }

  // Re-authenticate User (current password verification)
  Future<String?> reauthenticateUser(String currentPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Create a credential using the current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        // Reauthenticate the user
        await user.reauthenticateWithCredential(credential);
        return null; // Re-authentication successful
      }
      return 'No user is currently signed in';
    } on FirebaseAuthException catch (e) {
      logger.e("Re-authentication failed: $e");
      if (e.code == 'wrong-password') {
        return 'Current password is incorrect';
      }
      return 'An error occurred. Please try again later';
    }
  }

  // Update Username with re-authentication
  Future<String?> updateUsername(
      String newUsername, String currentPassword) async {
    try {
      String? reAuthResult = await reauthenticateUser(currentPassword);
      if (reAuthResult != null) {
        return reAuthResult; // If re-authentication fails, return the error message
      }

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

  // Update Password with re-authentication
  Future<String?> updatePassword(
      String newPassword, String currentPassword) async {
    try {
      String? reAuthResult = await reauthenticateUser(currentPassword);
      if (reAuthResult != null) {
        return reAuthResult; // If re-authentication fails, return the error message
      }

      // Now, update the password after re-authentication
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
      User? user = _auth.currentUser;

      if (user != null) {
        // First, delete the Firestore document
        await _firestore.collection('users').doc(user.uid).delete();

        // Then delete the user from Firebase Authentication
        await user.delete();

        logger.i("Account deleted successfully");
        return null; // Indicating success
      }
      return 'No user is currently signed in';
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
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();
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

  // Add a new diary entry
  Future<void> addDiaryEntry(String title, String date) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('diaryEntries').add({
          'title': title,
          'date': date,
          'createdAt': FieldValue.serverTimestamp(),
        });
        logger.i("Diary entry added successfully");
      }
    } catch (e) {
      logger.e("Error adding diary entry: $e");
    }
  }

  // Update an existing diary entry
  Future<void> updateDiaryEntry(String entryId, String title) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('diaryEntries').doc(entryId).update({
          'title': title,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        logger.i("Diary entry updated successfully");
      }
    } catch (e) {
      logger.e("Error updating diary entry: $e");
    }
  }

  // Delete a diary entry
  Future<void> deleteDiaryEntry(String entryId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('diaryEntries').doc(entryId).delete();
        logger.i("Diary entry deleted successfully");
      }
    } catch (e) {
      logger.e("Error deleting diary entry: $e");
    }
  }

  // Fetch all diary entries
  Future<List<Map<String, dynamic>>> fetchDiaryEntries() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await _firestore.collection('users').doc(user.uid).collection('diaryEntries').orderBy('createdAt', descending: true).get();
        return snapshot.docs.map((doc) => {
          'id': doc.id,
          'title': doc['title'],
          'date': doc['date'],
        }).toList();
      }
      return [];
    } catch (e) {
      logger.e("Error fetching diary entries: $e");
      return [];
    }
  }
}