import 'package:baqal/src/enums/auth-result-status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../core/utils/auth-exception-handler.dart';


class FirebaseRepository {
  var _firebaseAuth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  ///
  /// Helper Functions
  ///
  Future<AuthResultStatus> createAccount({email, pass}) async {
    try {
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, pass}) async {
    try {
      final authResult =
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;

      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  logout() async{
    try{
      await _firebaseAuth.signOut();
    }catch(e){
      print('Error from logout is $e');
    }
  }

  Future<bool> sendCode(
      String phoneNumber, {
        required PhoneVerificationCompleted verificationCompleted,
        required PhoneVerificationFailed verificationFailed,
        required PhoneCodeSent codeSent,
        required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
      }) async {
    try {
      return _firebaseAuth
          .verifyPhoneNumber(
          phoneNumber: "+$phoneNumber",
          timeout: Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {
        return true;
      }).catchError((e) {
        return false;
      });
    } on PlatformException {
      return false;
    }
  }

  setAccountDetails({required String displayName, String ? photoUrl}) async {
    // UserUpdateInfo updateInfo = UserUpdateInfo();
    // updateInfo.displayName = displayName;
    // updateInfo.photoUrl = photoUrl;
    await FirebaseAuth.instance.currentUser!.updateProfile(displayName:displayName);
    await FirebaseAuth.instance.currentUser!.updateProfile(photoURL: photoUrl);
    // (await getCurrentUser()).updateProfile(updateInfo);
  }

  Future<String> getUid() async {
    User user =  _firebaseAuth.currentUser!;
    return user.uid;
  }

  Future<String> getPhoneNumber() async {
    User user =  _firebaseAuth.currentUser!;
    return  user.phoneNumber!;
  }

  Future<User> getCurrentUser() async {
    User user =  _firebaseAuth.currentUser!;
    return user;
  }


  Future<bool> checkUserLoggedInStatus() async {
    try {
      User user = await getCurrentUser();
      if (user == null) {
        return false;
      } else
        return true;
    } catch (e) {
      return false;
    }
  }

}

