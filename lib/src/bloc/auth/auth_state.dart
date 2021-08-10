import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.idle() = Idle;

  const factory AuthState.codeCountDown(String value) = CodeCountDown;

  const factory AuthState.onButtonEnabled() = ButtonEnabled;

  const factory AuthState.onButtonDisabled() = ButtonDisabled;

  const factory AuthState.onPhoneLoading() = PhoneLoading;

  const factory AuthState.confirmOtpLoading() = ConfirmOtpLoading;

  const factory AuthState.registerLoading() = RegisterLoading;

  const factory AuthState.registerSuccessful() = RegisterSuccessful;

  const factory AuthState.isPhoneNumber() = PhoneNumberEntered;

  const factory AuthState.isEmail() = EmailEntered;

  const factory AuthState.resendOtpLoading() = ResendOtpLoading;

  const factory AuthState.autoFetchOtp(String otp) = AutoFetchOtp;

  const factory AuthState.loginPhoneSuccessFull() = LoginPhoneSuccessfull;

  const factory AuthState.loginEmailSuccessFull() = LoginEmailSuccessfull;

  const factory AuthState.loggedInUser() = LoggedInUser;

  const factory AuthState.loggedOutUser() = LoggedOutUser;

  const factory AuthState.otpSent() = OtpSent;

  const factory AuthState.loginLoading() = LoginLoading;

  const factory AuthState.showError(String error) = ShowError;

}
