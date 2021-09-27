import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/core/utils/trim.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_arguments.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_button.dart';

class LoginScreen extends StatefulWidget {
  final bool isForUpdatePhone;

  LoginScreen({this.isForUpdatePhone = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authCubit = getItInstance<AuthCubit>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpNumberController = TextEditingController();
  final languageProvider = getItInstance<LanguageProvider>();
  Validator validator = Validator();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      print(phoneController.text);
      authCubit.validateLoginButton(
        phoneNumber: phoneController.text,
        // ignore: unnecessary_statements
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.getTranslated(
            context,
            widget.isForUpdatePhone
                ? StringsConstants.changePhoneNumber
                : StringsConstants.login)!),
      ),
      body: _login(),
    );
  }

  Widget _login() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CustomTextField(
              textEditingController: phoneController,
              hint: languageProvider.getTranslated(
                  context, StringsConstants.phoneNumber)!,
              validator: validator.validateMobilePhone,
              prefix: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '+20',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              bloc: authCubit,
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

                return CommonButton(
                  title: languageProvider.getTranslated(
                      context, StringsConstants.continueText)!,
                  height: 50,
                  isEnabled: isButtonEnabled(),
                  replaceWithIndicator: state is PhoneLoading ? true : false,
                  onTap: onContinueButtonTapped,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onContinueButtonTapped() {
    if (_formKey.currentState!.validate()) {
      String trimmedNumber = TrimUtils.trimEnteredNumber(phoneController.text);
      routerUtils
          .pushNamedRoot(context, Routes.otpLoginScreen,
              arguments: OtpLoginScreenArguments(
                  phoneNumber: '20$trimmedNumber',
                  isForUpdatingPhoneNumber: widget.isForUpdatePhone))
          .then((value) {
        if (value != null) {
          phoneController.clear();
        }
      });
    }
  }
}
