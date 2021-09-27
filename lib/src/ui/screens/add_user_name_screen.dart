import 'package:baqal/src/bloc/account_details/account_details.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_arguments.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/screens/main_home_screen.dart';
import 'package:baqal/src/ui/screens/my_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/action_text.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';
import 'package:baqal/src/ui/common/common_button.dart';

class AddUserNameScreen extends StatefulWidget {
  final bool newName;

  AddUserNameScreen({required this.newName});

  @override
  _AddUserNameScreenState createState() => _AddUserNameScreenState();
}

class _AddUserNameScreenState extends State<AddUserNameScreen> {
  var addAccountDetailsCubit = getItInstance<AccountDetailsCubit>();
  final accountNotifier = getItInstance<AccountProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  TextEditingController nameEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Validator validator = Validator();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController(
        text: !widget.newName ? accountNotifier.accountDetails!.name : null);
    nameEditingController.addListener(() {
      addAccountDetailsCubit.validateEditNameButton(nameEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
            "${widget.newName ? languageProvider.getTranslated(context, StringsConstants.add) : languageProvider.getTranslated(context, StringsConstants.edit)} ${languageProvider.getTranslated(context, StringsConstants.name)}"),
      ),
      body: BlocConsumer<AccountDetailsCubit, AccountDetailsState>(
        bloc: addAccountDetailsCubit,
        listener: (BuildContext context, AccountDetailsState state) {
          if (state is Successful) {
            Future.delayed(Duration(milliseconds: 10)).then((value){
              if (widget.newName) {
                routerUtils.pushNamedAndRemoveUntil(context,  Routes.mainHomeScreen);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, Routes.mainHomeScreen, (_) => false);
              } else {
                routerUtils.pop(context);
                // Navigator.of(context).pop();
              }
            });
          }
          if (state is EditData) {
            nameEditingController.text = state.accountDetails.name!;
          }
        },
        builder: (BuildContext context, AccountDetailsState state) {
          if (state is Loading) {
            return Center(child: CommonAppLoader());
          } else {
            return saveDataView(state);
          }
        },
      ),
    );
  }

  Widget saveDataView(AccountDetailsState state) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              // Visibility(
              //   visible: !widget.newName,
              //   child: Container(
              //     margin: EdgeInsets.only(bottom: 20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: <Widget>[
              //         ActionText(
              //             title: StringsConstants.manageAddress,
              //             onTap: () {
              //               Navigator.pushNamed(context, Routes.myAddressScreen,);
              //             }),
              //       ],
              //     ),
              //   ),
              // ),
              CustomTextField(
                hint: languageProvider.getTranslated(context, StringsConstants.enterName),
                autoFocus: true,
                textEditingController: nameEditingController,
                validator: validator.validateNameFunction,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              CommonButton(
                title: widget.newName ? languageProvider.getTranslated(context, StringsConstants.add) : languageProvider.getTranslated(context, StringsConstants.edit),
                titleColor: AppColors.white,
                height: 50,
                isEnabled: isButtonEnabled(state),
                replaceWithIndicator: state is Loading ? true : false,
                margin: EdgeInsets.only(bottom: 40),
                onTap: () {
                  onButtonTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isButtonEnabled(AccountDetailsState state) {
    if (state is ButtonEnabled) {
      return true;
    } else if (state is ButtonDisabled) {
      return false;
    } else {
      return false;
    }
  }

  void onButtonTap() {
    if (_formKey.currentState!.validate()) {
      addAccountDetailsCubit.saveData(nameEditingController.text,  !widget.newName);
    }
  }
}
