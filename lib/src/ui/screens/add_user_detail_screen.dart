import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/notifiers/navigation_provider.dart';
import 'package:baqal/src/ui/screens/main_home_screen.dart';
import 'package:baqal/src/ui/screens/my_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_account_details/add_account_details.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/action_text.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';
import 'package:baqal/src/ui/common/common_button.dart';

class AddUserDetailScreen extends StatefulWidget {
  final bool newAddress;

  AddUserDetailScreen(this.newAddress);

  @override
  _AddUserDetailScreenState createState() => _AddUserDetailScreenState();
}

class _AddUserDetailScreenState extends State<AddUserDetailScreen> {
  var addAddressCubit = getItInstance<AddAccountDetailsCubit>();

  TextEditingController nameEditingController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Validator validator = Validator();
  @override
  void initState() {
    super.initState();
    if (!widget.newAddress) {
      addAddressCubit.loadPreviousData();
    }
    nameEditingController.addListener(() {
      addAddressCubit.validateButton(nameEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
            "${widget.newAddress ? StringsConstants.add : StringsConstants.edit} ${StringsConstants.details}"),
      ),
      body: BlocConsumer<AddAccountDetailsCubit, AddAccountDetailsState>(
        bloc: addAddressCubit,
        listener: (BuildContext context, AddAccountDetailsState state) {
          if (state is Successful) {
            if (widget.newAddress) {
              final navigationProvider = getItInstance<NavigationProvider>();
              if (navigationProvider.getPushingPageRoot == null) {
                Navigation.pushAndPopUntil(context, MainHomeScreen());

              } else {
                Navigator.of(context).popUntil(
                    ModalRoute.withName(navigationProvider.getPushingPageRoot));
              }
            } else {
              Navigator.of(context).pop();
            }
          }
          if (state is EditData) {
            nameEditingController.text = state.accountDetails.name!;
          }
        },
        builder: (BuildContext context, AddAccountDetailsState state) {
          if (state is Loading) {
            return Center(child: CommonAppLoader());
          } else {
            return saveDataView(state);
          }
        },
      ),
    );
  }

  Widget saveDataView(AddAccountDetailsState state) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: !widget.newAddress,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ActionText(title: StringsConstants.manageAddress, onTap: () {
                        Navigation.push(context,MyAddressScreen());
                      }),
                    ],
                  ),
                ),
              ),
              CustomTextField(
                hint: "Enter Name",
                textEditingController: nameEditingController,
                focusNode: nameFocusNode,
                nextFocusNode: phoneFocusNode,
                validator: validator.validateNameFunction,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onSubmitted: (val) {
                  FocusScope.of(context).requestFocus(phoneFocusNode);
                },
                // containerHeight: 50,
              ),
              SizedBox(
                height: 20,
              ),
              CommonButton(
                title: widget.newAddress ? "Add" : "Edit",
                titleColor: AppColors.white,
                height: 50,
                isEnabled: isButtonEnabled(state),
                replaceWithIndicator: state is SaveDataLoading ? true : false,
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

  bool isButtonEnabled(AddAccountDetailsState state) {
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
      addAddressCubit.saveData(nameEditingController.text,
          isEdit: widget.newAddress);
    }
  }
}
