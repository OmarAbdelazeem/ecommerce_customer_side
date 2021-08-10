import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:admin_side_ecommerce/src/bloc/login/login.dart' as login;
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/styles.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_button.dart';

import 'main_home_screen.dart';

class CreateAnAccountScreen extends StatefulWidget {
  @override
  _CreateAnAccountScreenState createState() => _CreateAnAccountScreenState();
}

class _CreateAnAccountScreenState extends State<CreateAnAccountScreen> {
  // var phoneLoginCubit = AppInjector.get<AuthCubit>();
  var authCubit = getItInstance<AuthCubit>();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneOrEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Validator validator = Validator();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // phoneOrEmailController.addListener(() {
    //   authCubit.phoneNumberOrPassword(phoneOrEmailController.text);
    //
    //   phoneLoginCubit.validateButton(
    //       phoneNumber: phoneOrEmailController.text,
    //       password: passwordController.text);
    // });

    // passwordController.addListener(() {
    //   print(passwordController.text);
    //   authCubit.validateLoginButton(
    //       password: passwordController.text,
    //       phoneNumber: phoneOrEmailController.text);
    // });
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[_registerCard()],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerCard() {
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
                'Registration',
                style: AppTextStyles.medium20Color20203E,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                StringsConstants.registerText,
                style: AppTextStyles.normal14Black,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: nameController,
                hint: 'Name',
                validator: validator.validateNameFunction,
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: authCubit,
                listener: (BuildContext context, AuthState state) {},
                builder: (context, state) {
                  return CustomTextField(
                    textEditingController: phoneOrEmailController,
                    hint: 'Email',
                    validator: validator.validateEmail,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: passwordController,
                hint: 'Password',
                validator: validator.validatePassword,
                // keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: authCubit,
                listener: (BuildContext context, AuthState state) {
                  state.when(
                    loggedInUser: (){},
                      loggedOutUser: (){},
                      otpSent: () {},
                      loginEmailSuccessFull: () {},
                      onPhoneLoading: () {},
                      loginLoading: () {},
                      isEmail: () {},
                      isPhoneNumber: () {},
                      registerLoading: () {},
                      registerSuccessful: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainHomeScreen()));
                      },
                      idle: () {},
                      confirmOtpLoading: () {},
                      autoFetchOtp: (_) {},
                      onButtonEnabled: () {},
                      resendOtpLoading: () {},
                      showError: (String error) {
                        print(error);
                      },
                      onButtonDisabled: () {},
                      loginPhoneSuccessFull: () {},
                      codeCountDown: (_) {});
                },
                builder: (BuildContext context, AuthState state) {
                  // bool isButtonEnabled() {
                  //   if (state is ButtonEnabled) {
                  //     return true;
                  //   } else if (state is ButtonDisabled) {
                  //     return false;
                  //   } else {
                  //     return true;
                  //   }
                  // }

                  return CommonButton(
                    title: 'Create Account',
                    height: 50,
                    isEnabled: true,
                    replaceWithIndicator:
                        state is RegisterLoading ? true : false,
                    onTap: onButtonTap,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonTap() {
    if (_formKey.currentState!.validate()) {
      authCubit.register(
          email: phoneOrEmailController.text,
          password: passwordController.text);
    }
  }
}
