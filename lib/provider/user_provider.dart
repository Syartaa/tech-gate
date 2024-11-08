import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotifier extends StateNotifier<AsyncValue<Users?>> {
  UserNotifier() : super(const AsyncValue.loading()) {
    _initializeAuthStateListener();
  }

  void _initializeAuthStateListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        print('Auth State: User is logged in with UID: ${user.uid}');
        await _loadUserData(user.uid);
      } else {
        print('Auth State: No user logged in. Redirecting to WelcomeScreen.');
        state = const AsyncValue.data(null); // Set state to no user
      }
    });
  }

  Future<bool> emailExists(String email) async {
    try {
      print('Checking if email $email exists...');
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1) // Limit to one result for performance
          .get();

      final exists = querySnapshot.docs.isNotEmpty;
      print('Email exists: $exists');
      return exists;
    } catch (e) {
      print('Error checking email existence: $e');
      return false; // If there is an error, assume email doesn't exist
    }
  }

  Future<void> _loadUserData(String userId) async {
    try {
      print('Loading user data for UID: $userId');
      state = const AsyncValue.loading();

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;

        if (data != null) {
          print('User data loaded successfully.');
          state = AsyncValue.data(Users(
            id: userId,
            firstName: data['firstName'] ?? '',
            lastName: data['lastName'] ?? '',
            email: data['email'] ?? '',
            birthday: (data['birthday'] as Timestamp).toDate(),
            phoneNumber: data['phoneNumber'] ?? '',
            gender: Gender.values.byName(data['gender'] ?? 'Male'),
            city: data['city'] ?? '',
            postalCode: data['postalCode'] ?? 0,
          ));
        } else {
          print('User document exists but data is null.');
          state = const AsyncValue.data(null); // Treat as no user data
        }
      } else {
        print('User document does not exist. Redirecting to WelcomeScreen.');
        state = const AsyncValue.data(null); // No document exists
      }
    } catch (e) {
      print('Error loading user data: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

// Sign Up Method
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime birthday,
    required String phoneNumber,
    required Gender gender,
    required String city,
    required int postalCode,
  }) async {
    try {
      state = const AsyncValue.loading();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user!.uid;
      print('User signed up with UID: $userId');

      // Create the user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'birthday': Timestamp.fromDate(birthday),
        'phoneNumber': phoneNumber,
        'gender': gender.name,
        'city': city,
        'postalCode': postalCode,
      });

      // Add a small delay to ensure the document is created
      await Future.delayed(const Duration(seconds: 1));

      // Load the user data after sign-up
      await _loadUserData(userId);
    } catch (e) {
      print('Error during sign-up: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Login Method
  Future<void> login(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      print('Starting login process for $email');

      // Check if the email exists in the database
      bool exists = await emailExists(email);
      if (!exists) {
        // Set an error state without changing user data
        state = AsyncValue.error(
          'Email or Password not Valid. Please sign up.',
          StackTrace.current,
        );

        return; // Stop further execution
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Login successful. Loading user data...');
      await _loadUserData(userCredential.user!.uid);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Logout Method
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    state = const AsyncValue.data(null);
  }

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required DateTime birthday,
    required String phoneNumber,
    required Gender gender,
    required String city,
    required int postalCode,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'firstName': firstName,
        'lastName': lastName,
        'birthday': Timestamp.fromDate(birthday),
        'phoneNumber': phoneNumber,
        'gender': gender.name,
        'city': city,
        'postalCode': postalCode,
      });
      await _loadUserData(user.uid); // Refresh user data after update
    }
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<Users?>>((ref) {
  return UserNotifier();
});
