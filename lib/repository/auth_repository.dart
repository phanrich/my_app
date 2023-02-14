import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/account.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentAccount = Account.empty;

  Stream<Account> get account {
    return _firebaseAuth.authStateChanges().map((firebaseAccount) {
      final account =
          firebaseAccount == null ? Account.empty : firebaseAccount.toAccount;
      return account;
    });
  }

  Future<void> signupwithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> signInWithCredential(
      {required firebase_auth.AuthCredential credential}) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
    } catch (_) {}
  }
// Future<void> signupwithEmail(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } catch (_) {}
//   }

  Future<void> loginWithPhone({
    required String phoneNumber,
    required Function(firebase_auth.PhoneAuthCredential) verificationCompleted,
    required Function(firebase_auth.FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }
}

extension on firebase_auth.User {
  Account get toAccount {
    return Account(
      id: uid,
      phone: phoneNumber,
      email: email,
      name: displayName,
    );
  }
}
