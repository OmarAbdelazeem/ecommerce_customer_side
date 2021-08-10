import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/enums/auth_type.dart';
import 'package:baqal/src/notifiers/navigation_provider.dart';
import 'package:baqal/src/ui/screens/create_an_account_screen.dart';
import 'package:baqal/src/ui/screens/main_home_screen.dart';
import 'package:baqal/src/ui/screens/otp_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/styles.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_button.dart';

class LoginScreen extends StatefulWidget {
  // final AuthType authType;

  // LoginScreen({@required this.authType});
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authCubit = getItInstance<AuthCubit>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Validator validator = Validator();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      print(phoneController.text);
      authCubit.validateLoginButton(
          phoneNumber: phoneController.text,
          password: passwordController.text
          // ignore: unnecessary_statements
          );
    });

    // if (widget.authType == AuthType.Email) {
    //   passwordController.addListener(() {
    //     print(passwordController.text);
    //     authCubit.validateLoginButton(
    //         authType: widget.authType,
    //         password: passwordController.text,
    //         phoneNumberOrEmail: phoneController.text);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Material(
            elevation: 5,
            child: Container(
              height: 250,
              width: width,
              decoration: BoxDecoration(
                gradient: Styles.appBackGradient,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // backgroundColor: Styles.transparent,
//            floatingActionButton: _floatingActionButton(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: Container(
                child: Column(
                  children: <Widget>[_loginCard()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginCard() {
    return Card(
      margin: EdgeInsets.only(top: 50, right: 16, left: 16),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                StringsConstants.login,
                style: AppTextStyles.medium20Color20203E,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                StringsConstants.phoneLoginText,
                style: AppTextStyles.normal14Black,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: phoneController,
                hint: 'Phone number',
                validator: validator.validateMobilePhone,
                keyboardType: TextInputType.phone,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // authType == AuthType.Email
              //     ? CustomTextField(
              //         textEditingController: passwordController,
              //         hint: 'Password',
              //         validator: validator.validatePassword,
              //         // keyboardType: TextInputType.phone,
              //       )
              //     : Container(),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: authCubit,
                listener: (BuildContext context, AuthState state) {
                  state.when(
                      idle: () {},
                      loggedInUser: () {},
                      loggedOutUser: () {},
                      codeCountDown: (_) {},
                      onButtonEnabled: () {},
                      onButtonDisabled: () {},
                      onPhoneLoading: () {},
                      confirmOtpLoading: () {},
                      registerLoading: () {},
                      registerSuccessful: () {},
                      isPhoneNumber: () {},
                      isEmail: () {},
                      resendOtpLoading: () {},
                      autoFetchOtp: (_) {},
                      otpSent: () {
                        // Navigator.of(context).pushNamed(
                        //   Routes.otpLoginScreen,
                        // );
                      },
                      loginPhoneSuccessFull: () {},
                      loginEmailSuccessFull: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => MainHomeScreen(),
                        //   ),
                        // );
                      },
                      loginLoading: () {},
                      showError: (error) {
                        print('error is $error');
                      });
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

                  return CommonButton(
                    title: 'Continue',
                    height: 50,
                    isEnabled: isButtonEnabled(),
                    replaceWithIndicator: state is PhoneLoading ? true : false,
                    onTap: () {
                      onButtonTap();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonTap() {
      if (_formKey.currentState!.validate()) {
        if (_formKey.currentState!.validate()) {
          Navigation.push(context, OtpLoginScreen(phoneNumber: phoneController.text))
              .then((value) {
            if (value != null) {
              phoneController.clear();
            }
          });
        }
    }
  }
}
