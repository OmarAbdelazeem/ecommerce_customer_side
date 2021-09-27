import 'package:baqal/src/bloc/account_details/account_details.dart'
    as account_details;
import 'package:baqal/src/bloc/add_to_cart/add_to_cart.dart';
import 'package:baqal/src/bloc/addresses/addresses.dart';
import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/bloc/check_user_data/check_user_data.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_arguments.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/loading_dialogue.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpLoginScreen extends StatefulWidget {
  final OtpLoginScreenArguments otpLoginScreenArguments;

  OtpLoginScreen(this.otpLoginScreenArguments);

  @override
  _OtpLoginScreenState createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  var authCubit = getItInstance<AuthCubit>();
  final accountProvider = getItInstance<AccountProvider>();

  TextEditingController otpNumberController = TextEditingController();

  final languageProvider = getItInstance<LanguageProvider>();

  Validator validator = Validator();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final accountDetailsCubit =
      getItInstance<account_details.AccountDetailsCubit>();

  final routerUtils = getItInstance<RouterUtils>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final addressesCubit = getItInstance<AddressesCubit>();
  final checkUserDataCubit = getItInstance<CheckUserDataCubit>();
  final addToCartCubit = getItInstance<AddToCartCubit>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authCubit.sendOtp(widget.otpLoginScreenArguments.phoneNumber,
        isForUpdatePhoneNumber: true);
    otpNumberController.addListener(() {
      print(otpNumberController.text);
      authCubit.validateButtonForOtp(otpNumberController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            languageProvider.getTranslated(context, StringsConstants.login)!),
      ),
      body: _loginCard(),
    );
  }

  Widget _loginCard() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              languageProvider.getTranslated(
                  context, StringsConstants.mobileVerificationDesc)!,
              style: AppTextStyles.normalText,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                InkWell(
                  child: Text(
                    languageProvider.getTranslated(
                        context, StringsConstants.changeNumber)!,
                    style: AppTextStyles.normalText,
                  ),
                  onTap: () {
                    routerUtils.pop(context, true);
                    // Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              textEditingController: otpNumberController,
              hint: languageProvider.getTranslated(
                  context, StringsConstants.enterVerificationCode),
              validator: validator.validate6DigitCode,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              bloc: authCubit,
              listener: (BuildContext context, AuthState state) async {
                if (state is ConfirmOtpLoading) {
                  showLoadingDialog(context, _keyLoader);
                } else if (state is AutoFetchOtp) {
                  otpNumberController.text = state.otp;
                } else if (state is LoginPhoneSuccessfull) {
                  if (widget.otpLoginScreenArguments.isForUpdatingPhoneNumber) {
                    accountDetailsCubit
                        .updatePhoneNumber(
                            widget.otpLoginScreenArguments.phoneNumber)
                        .then((value) {
                      if (value) routerUtils.popUntil(context);
                    });
                  } else {
                    await FirebaseMessaging.instance.subscribeToTopic(
                        '${languageProvider.locale!.languageCode}CustomersNotifications');
                    checkUserDataCubit.checkUserData();
                  }
                }
              },
              builder: (BuildContext context, AuthState state) {
                bool isButtonEnabled() {
                  if (state is ButtonEnabled) {
                    return true;
                  } else if (state is ButtonDisabled) {
                    return false;
                  } else {
                    return true;
                  }
                }

                return Column(
                  children: [
                    CommonButton(
                      title: languageProvider.getTranslated(
                          context, StringsConstants.confirmVerificationCode),
                      height: 50,
                      isEnabled: isButtonEnabled(),
                      onTap: onConfirmButtonTapped,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: state is ShowError
                          ? Text(
                              '${state.error}',
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              bloc: authCubit,
              builder: (BuildContext context, AuthState state) {
                if (state is ResendOtpLoading) return CommonAppLoader();
                return Text(
                  languageProvider.getTranslated(
                      context, StringsConstants.resendVerificationCodeText)!,
                  style: AppTextStyles.normalText,
                );
              },
            ),
            BlocConsumer<CheckUserDataCubit, CheckUserDataState>(
              bloc: checkUserDataCubit,
              listener: (context, CheckUserDataState state) async {
                if (state is UserDataNotFound) {
                  Future.delayed(Duration(milliseconds: 1)).then((value) {
                    Navigator.of(_keyLoader.currentContext!,
                            rootNavigator: true)
                        .pop();
                    routerUtils.pushNamedAndRemoveUntil(
                        context, Routes.addUserNameScreen,
                        arguments: true);
                  });
                } else if (state is Finished) {
                  await accountDetailsCubit
                      .updateLanguage(languageProvider.locale!.languageCode);
                  // get customer token

                  String? token = await FirebaseMessaging.instance.getToken();
                  await accountDetailsCubit.updateToken(token!);

                  await addToCartCubit
                      .transformItemsFromLocalCartToOnlineCart();
                  await addressesCubit.fetchAddresses();

                  Future.delayed(Duration(milliseconds: 10)).then((_) {
                    Navigator.of(_keyLoader.currentContext!,
                            rootNavigator: true)
                        .pop();
                    routerUtils.popUntil(context);
                  });
                }
              },
              builder: (context, CheckUserDataState state) {
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void onConfirmButtonTapped() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      authCubit.loginWithOtp(
          smsCode: otpNumberController.text.trim(),
          isForUpdatePhone:
              widget.otpLoginScreenArguments.isForUpdatingPhoneNumber);
    }
  }

}

