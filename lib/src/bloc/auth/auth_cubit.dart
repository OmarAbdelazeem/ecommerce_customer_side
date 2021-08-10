import 'dart:async';
import 'package:baqal/src/core/utils/auth-exception-handler.dart';
import 'package:baqal/src/enums/auth-result-status.dart';
import 'package:baqal/src/enums/auth_type.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/auth/auth_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'auth.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  FirebaseRepository _firebaseRepo = getItInstance<FirebaseRepository>();
 late AuthResultStatus _authResultStatus;

  AuthCubit() : super(AuthState.onButtonDisabled());
  late String _verificationId;
  AccountProvider ? _accountProvider  = getItInstance<AccountProvider>();

  validateButtonForOtp(String otp) {
    if (otp.length == 6) {
      emit(AuthState.onButtonEnabled());
    } else {
      emit(AuthState.onButtonDisabled());
    }
  }

  validateLoginButton(
      {required String phoneNumber,
        required String password,
     }) {
    if (phoneNumber.isNotEmpty && phoneNumber.length > 10) {
      emit(AuthState.onButtonEnabled());
    } else {
      emit(AuthState.onButtonDisabled());
    }
  }

  sendOtp(String phoneNumber) async {
    _firebaseRepo.sendCode(phoneNumber,
        codeSent: (String verificationId, int ? forceResendingToken) async {
      _verificationId = verificationId;
      Timer.periodic(Duration(seconds: 60), (timer) {
        emit(AuthState.codeCountDown(
            "00:${timer.tick < 10 ? "0${timer.tick}" : "${timer.tick}"}"));
      });
    }, codeAutoRetrievalTimeout: (String verificationId) {
      _verificationId = verificationId;
      emit(AuthState.showError(""));
    }, verificationFailed: (FirebaseAuthException authException) {
//          emit(OtpLoginState.showError(FirebaseErrors.checkAuthError(authException.message)));
      emit(AuthState.showError(authException.message!));
    }, verificationCompleted: (AuthCredential auth) {
      emit(AuthState.autoFetchOtp("******"));
      _loginPhone(authCred: auth, otpLogged: false);
    });
  }

  loginWithOtp(String smsCode) async {
    emit(AuthState.confirmOtpLoading());
    try {
      var _credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);
      if (_credential != null) {
        _authResultStatus = AuthResultStatus.successful;
      } else {
        _authResultStatus = AuthResultStatus.wrongVerificationCode;
      }
      await _loginPhone(authCred: _credential, otpLogged: true);
      _accountProvider!.user = await _firebaseRepo.getCurrentUser();
    } catch (e) {
      emit(AuthState.showError(e.toString()));
    }
  }

  _loginPhone({required AuthCredential authCred, required bool otpLogged}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      UserCredential ? authResult = await firebaseAuth.signInWithCredential(authCred);
      if (authResult.credential != null) {
        _authResultStatus = AuthResultStatus.successful;
        otpLogged
            ? emit(AuthState.loginPhoneSuccessFull())
            : emit(AuthState.otpSent());
      } else {
        _authResultStatus = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('e is $e');
      // custom , should be modifying later
      _authResultStatus = AuthExceptionHandler.handleException(e);
      emit(AuthState.showError(
          AuthExceptionHandler.generateExceptionMessage(_authResultStatus)));
    }
  }

  register(
      {String email = '',
      String phoneNumber = '',
      String password = ''}) async {
    emit(AuthState.registerLoading());
    try {
      if (email.isNotEmpty &&
          email != null &&
          password.isNotEmpty &&
          password != null) {
        await _firebaseRepo.createAccount(email: email, pass: password);
        emit(AuthState.registerSuccessful());
        _accountProvider!.user = await _firebaseRepo.getCurrentUser();
      }
    } catch (error) {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(error);

      emit(AuthState.showError(errorMsg));
    }
    /*
    Todo : Transform this to state

    if (status == AuthResultStatus.successful) {
      // Navigate to success page
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      _showAlertDialog(errorMsg);
    }
    * */
  }

  void loginWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthState.loginLoading());
    try {
      final status = await _firebaseRepo.login(email: email, pass: password);

      if (status == AuthResultStatus.successful) {
        emit(AuthState.loginEmailSuccessFull());
        _accountProvider!.user = await _firebaseRepo.getCurrentUser();
        // _isUserLoggedIn = true;
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        emit(AuthState.showError(errorMsg));
        throw errorMsg;
      }
    } catch (e) {
      print('from login $e');
    }
  }

  // _saveData(AccountDetails accountDetails) {
  //   _firestoreRepo.addUserDetails(accountDetails).then((value) {
  //     emit(AddressCardState.successful());
  //   }).catchError((e) {
  //     emit(AddressCardState.error(e.toString()));
  //   });
  // }

  void logout() async {
    try {
      await _firebaseRepo.logout();
      _accountProvider!.user = null;
      emit(AuthState.loggedOutUser());
    } catch (e) {
      print(e);
    }
  }
}
