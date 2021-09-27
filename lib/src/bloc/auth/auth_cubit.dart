import 'dart:async';
import 'package:baqal/src/core/utils/auth-exception-handler.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/core/utils/firebase_error.dart';
import 'package:baqal/src/enums/auth-result-status.dart';
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
  AccountProvider? _accountProvider = getItInstance<AccountProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;

  validateButtonForOtp(String otp) {
    if (otp.length == 6) {
      emit(AuthState.onButtonEnabled());
    } else {
      emit(AuthState.onButtonDisabled());
    }
  }

  validateLoginButton({
    required String phoneNumber,
  }) {
    if (phoneNumber.isNotEmpty && phoneNumber.length > 9) {
      emit(AuthState.onButtonEnabled());
    } else {
      emit(AuthState.onButtonDisabled());
    }
  }

  sendOtp(String phoneNumber, {bool isForUpdatePhoneNumber = false}) async {
    _firebaseRepo.sendCode(phoneNumber,
        codeSent: (String verificationId, int? forceResendingToken) async {
      _verificationId = verificationId;
      Timer.periodic(Duration(seconds: 60), (timer) {
        emit(AuthState.codeCountDown(
            "00:${timer.tick < 10 ? "0${timer.tick}" : "${timer.tick}"}"));
      });
    }, codeAutoRetrievalTimeout: (String verificationId) {
      _verificationId = verificationId;
      emit(AuthState.showError(""));
    }, verificationFailed: (FirebaseAuthException authException) {
      emit(AuthState.showError(
          FirebaseErrors.checkAuthError(authException.message!)));
      emit(AuthState.showError(authException.message!));
    }, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
      emit(AuthState.autoFetchOtp("******"));

      isForUpdatePhoneNumber
          ? _updatePhoneNumber(phoneAuthCredential: phoneAuthCredential)
          : _loginPhone(authCred: phoneAuthCredential, otpLogged: true);
    });
  }

  loginWithOtp(
      {required String smsCode, required bool isForUpdatePhone}) async {
    emit(AuthState.confirmOtpLoading());
    try {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);
      if (credential != null) {
        _authResultStatus = AuthResultStatus.successful;
      } else {
        _authResultStatus = AuthResultStatus.wrongVerificationCode;
      }
      if (isForUpdatePhone) {
        print('isForUpdatePhone');
        await _updatePhoneNumber(phoneAuthCredential: credential);
        await _loginPhone(authCred: credential, otpLogged: true);
      } else
        await _loginPhone(authCred: credential, otpLogged: true);

      _accountProvider!.user = await _firebaseRepo.getCurrentUser();
    } catch (e) {
      emit(AuthState.showError(e.toString()));
    }
  }

  _loginPhone(
      {required AuthCredential authCred, required bool otpLogged}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      UserCredential? authResult =
          await firebaseAuth.signInWithCredential(authCred);
      print('authResult.credential is ${authResult.credential}');
      otpLogged
          ? emit(AuthState.loginPhoneSuccessFull())
          : emit(AuthState.otpSent());
      _authResultStatus = AuthResultStatus.successful;
    } catch (e) {
      print('e is $e');
      _authResultStatus = AuthExceptionHandler.handleException(e);
      emit(AuthState.showError(
          AuthExceptionHandler.generateExceptionMessage(_authResultStatus)));
    }
  }

  Future _updatePhoneNumber(
      {required PhoneAuthCredential phoneAuthCredential}) async {
    try {
      _firebaseRepo.updatePhoneNumber(phoneAuthCredential);
      _authResultStatus = AuthResultStatus.successful;
      emit(AuthState.loginPhoneSuccessFull());
    } catch (e) {
      print('e is $e');
      _authResultStatus = AuthExceptionHandler.handleException(e);
      emit(AuthState.showError(
          AuthExceptionHandler.generateExceptionMessage(_authResultStatus)));
    }
  }

  Future logout() async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (hasConnection) {
      try {
        await _firebaseRepo.logout();
        _accountProvider!.user = null;
        emit(AuthState.loggedOutUser());
      } catch (e) {
        print(e);
      }
    }
  }
}
