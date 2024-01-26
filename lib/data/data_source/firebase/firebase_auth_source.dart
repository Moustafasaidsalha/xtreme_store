import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/firebase_options.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class FirebaseAuthSource {
  Stream<User?> get onAuthStateChanged;
  String? getCurrentUserUID();
  Future<UserCredential> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithGoogleProvider();
  Future<UserCredential> signInWithAppleProvider();
  Future<void> verifyEmailUser(User user);
  Future<void> addUserDisplayName(User user, String name);
  Future<void> forgetPassword(String email);
  Future<void> signOut();
}

class FirebaseAuthSourceImpl implements FirebaseAuthSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  @override
  String? getCurrentUserUID() {
    String? uid = _firebaseAuth.currentUser?.uid;
    return uid;
  }

  @override
  Future<UserCredential> createNewUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.code);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserCredential> signInWithGoogleProvider() async {
    try {
      late GoogleSignIn googleSignIn;
      if (Platform.isIOS) {
        googleSignIn = GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
        );
      } else {
        googleSignIn = GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.androidClientId,
        );
      }
      // GoogleSignIn googleSignIn = GoogleSignIn(
      //   clientId: DefaultFirebaseOptions.currentPlatform.iosClientId
      //   // clientId:
      //   //     "570288645491-8gfku5a5n9vj3su5s20b19u5smkagqs2.apps.googleusercontent.com",
      //   // serverClientId:
      //   //     "com.googleusercontent.apps.570288645491-8gfku5a5n9vj3su5s20b19u5smkagqs2",
      // );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final oACredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final credential = await _firebaseAuth.signInWithCredential(oACredential);
        return credential;
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw FirebaseAuthException(code: e.code);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception();
    }
  }

  @override
  Future<UserCredential> signInWithAppleProvider() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      return await _firebaseAuth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<void> verifyEmailUser(User user) async {
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (_) {
      throw ServerException();
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> addUserDisplayName(User user, String name) async {
    try {
      await user.updateDisplayName(name);
    } on FirebaseAuthException catch (_) {
      throw ServerException();
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.code);
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      late GoogleSignIn googleSignIn;
      if (Platform.isIOS) {
        googleSignIn = GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
        );
      } else {
        googleSignIn = GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.androidClientId,
        );
      }
      googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
