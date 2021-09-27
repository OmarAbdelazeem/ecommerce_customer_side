import 'package:baqal/src/bloc/account_details/account_details.dart';
import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/bloc/internet_connection/internet_connection.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/language_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/notifiers/main_home_screen_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:baqal/src/ui/common/no_internet_connection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthCubit _authCubit = getItInstance<AuthCubit>();

  InternetConnectionCubit internetConnectionCubit =
      getItInstance<InternetConnectionCubit>();
  final languageNotifier = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();
  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      bloc: internetConnectionCubit,
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                languageNotifier.getTranslated(
                    context, StringsConstants.profile)!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: state is NoInternetConnection
                ? noInternetConnection()
                : state is ConnectedSuccessfully
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProviderNotifier(
                          child: (AccountProvider accountProvider) {
                            return SingleChildScrollView(
                              child: accountProvider.user != null &&
                                      accountProvider.accountDetails != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              child: Text(
                                                accountProvider
                                                    .accountDetails!.name![0],
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, right: 16, top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Text(
                                                                accountProvider
                                                                    .accountDetails!
                                                                    .name!,
                                                                style: AppTextStyles
                                                                    .normalText,
                                                              ),
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .mode_edit,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    if (isConnected)
                                                                      routerUtils.pushNamedRoot(
                                                                          context,
                                                                          Routes
                                                                              .addUserNameScreen,
                                                                          arguments:
                                                                              false);
                                                                    // Navigator.pushNamed(
                                                                    //     context,
                                                                    //     Routes
                                                                    //         .addUserNameScreen,
                                                                    //     arguments:
                                                                    //         false);
                                                                  })
                                                            ],
                                                          ),
                                                          Text(
                                                            accountProvider
                                                                .accountDetails!
                                                                .phoneNumber!,
                                                            style: AppTextStyles
                                                                .normalText,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        optionItem(StringsConstants.myOrders,
                                            () {
                                          if (isConnected)
                                            routerUtils.pushNamedRoot(
                                                context, Routes.myOrdersScreen);
                                          // Navigator.pushNamed(
                                          //     context, Routes.myOrdersScreen);
                                        }, Icon(Icons.shopping_basket)),
                                        optionItem(StringsConstants.myAddress,
                                            () {
                                          if (isConnected)
                                            routerUtils.pushNamedRoot(
                                                context, Routes.myAddressScreen,
                                                arguments: false);
                                          // Navigator.pushNamed(
                                          //     context, Routes.myAddressScreen,
                                          //     arguments: false);
                                        }, Icon(Icons.home)),
                                        optionItem(
                                            languageNotifier
                                                .languageOption!.name,
                                            chooseLanguageDialogue,
                                            Icon(Icons.language)),
                                        optionItem(
                                          StringsConstants.changePhoneNumber,
                                          () {
                                            routerUtils.pushNamedRoot(
                                                context, Routes.loginScreen,
                                                arguments: true);
                                            // Navigator.pushNamed(
                                            //     context, Routes.loginScreen,
                                            //     arguments: true);
                                          },
                                          Icon(Icons.phone_android),
                                        ),
                                        Divider(),
                                        optionItem(StringsConstants.logout,
                                            () async {
                                          if (isConnected) {
                                            final mainHomeScreenProvider =
                                                getItInstance<
                                                    MainHomeScreenProvider>();
                                            mainHomeScreenProvider
                                                .setNavigationIndex = 0;
                                            mainHomeScreenProvider
                                                .pageController
                                                .jumpToPage(0);

                                            await _authCubit.logout();

                                            await FirebaseMessaging.instance
                                                .deleteToken();

                                            final cartStatusProvider =
                                                getItInstance<
                                                    CartStatusProvider>();
                                            cartStatusProvider.emptyingCart();
                                          }
                                        }, Icon(Icons.exit_to_app)),
                                      ],
                                    )
                                  : signInAndRegister(context),
                            );
                          },
                        ),
                      )
                    : Container());
      },
    );
  }

  Widget signInAndRegister(BuildContext context) {
    void loginOrCreateAccountFunction() {
      routerUtils.pushNamedRoot(context, Routes.loginScreen, arguments: false);
      // Navigator.pushNamed(context, Routes.loginScreen, arguments: false);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          'Welcome !',
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple),
        ),
        SizedBox(
          height: 30,
        ),
        CommonButton(
          title: 'Create an account',
          onTap: loginOrCreateAccountFunction,
          fontSize: 20,
          buttonColor: Colors.yellow.shade700,
        ),
        SizedBox(
          height: 30,
        ),
        CommonButton(
          title: 'SignIn',
          onTap: loginOrCreateAccountFunction,
          titleColor: Colors.deepPurple,
          buttonColor: Colors.white,
          fontSize: 20,
          borderSideColor: Colors.deepPurple,
        ),
        SizedBox(
          height: 15,
        ),
        optionItem(languageNotifier.languageOption!.name,
            chooseLanguageDialogue, Icon(Icons.language)),
      ],
    );
  }

  // Widget optionItem(String? title, Function()? onTap, Icon? icon,
  //     [Color? textColor]) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       height: 40,
  //       margin: EdgeInsets.only(left: 10),
  //       child: Row(
  //         children: [
  //           icon!,
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Text(
  //             title!,
  //             style: TextStyle(fontSize: 17, color: textColor ?? Colors.black),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget optionItem(
    String? title,
    Function()? onTap,
    Icon? icon,
  ) {
    return ListTile(
      title: Text(languageNotifier.getTranslated(context, title!)!),
      leading: icon,
      onTap: onTap,
    );
  }

  void chooseLanguageDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext dialogueContext) {
          void changeLanguage() {
            final accountProvider = getItInstance<AccountProvider>();
            final accountDetailsCubit = getItInstance<AccountDetailsCubit>();
            languageNotifier.changeLanguage(languageNotifier.languageOption);
            if (accountProvider.user != null)
              accountDetailsCubit.updateLanguage(
                  languageNotifier.languageOption!.languageCode);
            FirebaseMessaging.instance.subscribeToTopic(
                '${languageNotifier.languageOption!.languageCode}CustomersNotifications');
            Navigator.pop(dialogueContext);
          }

          return StatefulBuilder(builder: (context, setState) {
            void onLanguageOptionChanged(LanguageModel? value) {
              setState(() {
                languageNotifier.languageOption = value;
              });
            }

            languageRadioButton(LanguageModel languageModel) {
              return ListTile(
                title: Text(languageNotifier.getTranslated(
                    context, languageModel.name)!),
                leading: Radio(
                  value: languageModel,
                  groupValue: languageNotifier.languageOption,
                  onChanged: onLanguageOptionChanged,
                ),
              );
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text(languageNotifier.getTranslated(
                  context, StringsConstants.chooseLanguage)!),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    languageRadioButton(LanguageModel.languageList()[0]),
                    languageRadioButton(LanguageModel.languageList()[1]),
                    ElevatedButton(
                      onPressed: changeLanguage,
                      child: Text(languageNotifier.getTranslated(
                          context, StringsConstants.changeLanguage)!),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
