import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_address/add_address.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_button.dart';

class AddAddressScreen extends StatefulWidget {
  final bool newAddress;
  final Address ? editAddress;

  AddAddressScreen(this.newAddress,{this.editAddress});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  var addAddressCubit = getItInstance<AddAddressCubit>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController stateEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode pincodeFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  Validator validator = Validator();

 late bool setAsDefault;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final accountProvider = getItInstance<AccountProvider>();

  @override
  void initState() {
    super.initState();
    setAsDefault = false;
    if (widget.editAddress != null) {
      Address address = widget.editAddress!;
      nameEditingController.text = address.name;
      addressEditingController.text = address.address;
      cityEditingController.text = address.city;
      phoneEditingController.text = address.phoneNumber;
      setAsDefault = address.isDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("${widget.newAddress ? "Add" : "Edit"} Address"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: widget.newAddress,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        StringsConstants.addNewAddress,
                        style: AppTextStyles.medium14Black,
                      ),
                    ),
                  ),
                  CustomTextField(
                    hint: StringsConstants.name,
                    textEditingController: nameEditingController,
                    focusNode: nameFocusNode,
                    nextFocusNode: pincodeFocusNode,
                    validator: validator.validateNameFunction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(pincodeFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: StringsConstants.address,
                    textEditingController: addressEditingController,
                    focusNode: addressFocusNode,
                    nextFocusNode: cityFocusNode,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Address is Required";
                      } else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(cityFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: StringsConstants.city,
                    textEditingController: cityEditingController,
                    focusNode: cityFocusNode,
                    nextFocusNode: stateFocusNode,
                    validator: (val) => validator.validateText(val!, "City"),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(stateFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: StringsConstants.state,
                    textEditingController: stateEditingController,
                    focusNode: stateFocusNode,
                    nextFocusNode: phoneFocusNode,
                    validator: (val) => validator.validateText(val!, "State"),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(phoneFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: StringsConstants.phoneNumber,
                    textEditingController: phoneEditingController,
                    focusNode: phoneFocusNode,
                    validator: validator.validateMobilePhone,
                    keyboardType: TextInputType.phone,
                    onChanged: (val) {
                      if (validator.validateMobilePhone(val) == null) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return Checkbox(
                            value: setAsDefault,
                            onChanged: (bool? value) {
                              setState(() {
                                setAsDefault = value!;
                              });
                            },
                          );
                        },
                      ),
                      Text(
                        StringsConstants.setAsDefaultCaps,
                        style: AppTextStyles.medium14Black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  BlocConsumer<AddAddressCubit, AddAddressState>(
                    bloc: addAddressCubit,
                    listener: (BuildContext context, AddAddressState state) {
                      if (state is Successful) {
                        Navigator.of(context).pop(true);
                      }
                    },
                    builder: (BuildContext context, AddAddressState state) {
                      return CommonButton(
                        title: StringsConstants.save,
                        titleColor: AppColors.white,
                        height: 50,
                        replaceWithIndicator: state is ButtonLoading,
                        //isDisabled:
                        margin: EdgeInsets.only(bottom: 40),
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
        ),
      ),
    );
  }

  void onButtonTap() {
    if (_formKey.currentState!.validate()) {
      Address address = Address(
          name: nameEditingController.text,
          address: addressEditingController.text,
          city: cityEditingController.text,
          isDefault: setAsDefault,
          phoneNumber: "+2${phoneEditingController.text}",
          state: stateEditingController.text);
      addAddressCubit.saveAddress(address);
      accountProvider.addressSelected = address;
    }
  }
}
