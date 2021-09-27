import 'package:baqal/src/bloc/addresses/addresses.dart';
import 'package:baqal/src/core/utils/trim.dart';
import 'package:baqal/src/models/delivery_area.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/delivery_areas_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:uuid/uuid.dart';

// area , street name , building number , Floor number  , landmark/special sign , address description , mobile number
class AddOrEditAddressScreen extends StatefulWidget {
  final Address? editAddress;

  AddOrEditAddressScreen({this.editAddress});

  @override
  _AddOrEditAddressScreenState createState() => _AddOrEditAddressScreenState();
}

class _AddOrEditAddressScreenState extends State<AddOrEditAddressScreen> {
  var addressesCubit = getItInstance<AddressesCubit>();
  final deliveryAreasProvider = getItInstance<DeliveryAreasProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  late TextEditingController nameController;

  late TextEditingController addressDescriptionController;

  late TextEditingController streetNameController;

  late TextEditingController buildingNumberController;

  late TextEditingController floorNumberController;

  late TextEditingController landMarkController;

  late TextEditingController phoneController;

  FocusNode nameFocusNode = FocusNode();
  FocusNode addressDescriptionFocusNode = FocusNode();
  FocusNode streetNameFocusNode = FocusNode();
  FocusNode buildingNumberFocusNode = FocusNode();
  FocusNode floorNumberFocusNode = FocusNode();
  FocusNode landMarkFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  Validator validator = Validator();

  String? areaDropdownValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {
    super.initState();
    setUpControllers();
  }

  void setUpControllers() {
    if (widget.editAddress != null) {
      Address address = widget.editAddress!;
      print(address.streetName);

      areaDropdownValue = address.area;

      nameController = TextEditingController(text: address.name);
      addressDescriptionController =
          TextEditingController(text: address.addressDescription);
      buildingNumberController =
          TextEditingController(text: address.buildingNumber);
      floorNumberController = TextEditingController(text: address.floorNumber);
      landMarkController = TextEditingController(text: address.landmarkSign);
      streetNameController = TextEditingController(text: address.streetName);
      phoneController = TextEditingController(
          text: TrimUtils.trimDisplayedPhoneNumber(address.phoneNumber));
    } else {
      nameController = TextEditingController();
      addressDescriptionController = TextEditingController();
      streetNameController = TextEditingController();
      buildingNumberController = TextEditingController();
      floorNumberController = TextEditingController();
      landMarkController = TextEditingController();
      phoneController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
            "${widget.editAddress == null ? languageProvider.getTranslated(context, StringsConstants.add) : languageProvider.getTranslated(context, StringsConstants.edit)} ${languageProvider.getTranslated(context, StringsConstants.address)}"),
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
                  // Visibility(
                  //   visible: widget.newAddress,
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 30),
                  //     child: Text(
                  //       StringsConstants.addNewAddress,
                  //       style: AppTextStyles.medium14Black,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  areaDropDownButton(),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: languageProvider.getTranslated(
                        context, StringsConstants.streetName),
                    textEditingController: streetNameController,
                    initialValue: streetNameController.text,
                    focusNode: streetNameFocusNode,
                    nextFocusNode: buildingNumberFocusNode,
                    validator: (val) => validator.validateRequiredText(
                        val!, StringsConstants.streetName),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context)
                          .requestFocus(buildingNumberFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: languageProvider.getTranslated(
                        context, StringsConstants.buildingNumber),
                    isValidatorRequired: false,
                    textEditingController: buildingNumberController,
                    focusNode: buildingNumberFocusNode,
                    nextFocusNode: floorNumberFocusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(floorNumberFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: languageProvider.getTranslated(
                        context, StringsConstants.floorNumber),
                    isValidatorRequired: false,
                    textEditingController: floorNumberController,
                    focusNode: floorNumberFocusNode,
                    nextFocusNode: addressDescriptionFocusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(landMarkFocusNode);
                    },
                    // containerHeight: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: languageProvider.getTranslated(
                        context, StringsConstants.landMarkOrSpecialSign),
                    textEditingController: landMarkController,
                    focusNode: landMarkFocusNode,
                    nextFocusNode: phoneFocusNode,
                    validator: (val) =>
                        validator.validateNotRequiredText(val!, "State"),
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
                    hint: languageProvider.getTranslated(
                        context, StringsConstants.addressDescription),
                    textEditingController: addressDescriptionController,
                    focusNode: addressDescriptionFocusNode,
                    nextFocusNode: phoneFocusNode,
                    validator: (val) => validator.validateNotRequiredText(
                        val!, StringsConstants.addressDescription),
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
                    hint: languageProvider.getTranslated(
                        context, StringsConstants.phoneNumber),
                    textEditingController: phoneController,
                    inputDecorationIcon: Text('+20'),
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
                    height: 50,
                  ),
                  BlocConsumer<AddressesCubit, AddressesState>(
                    bloc: addressesCubit,
                    listener: (BuildContext context, AddressesState state) {
                      if (state is Successful) {
                        routerUtils.pop(context);
                        // Navigator.of(context).pop();
                      }
                    },
                    builder: (BuildContext context, AddressesState state) {
                      return CommonButton(
                        title: languageProvider.getTranslated(
                            context, StringsConstants.save),
                        titleColor: AppColors.white,
                        height: 50,
                        replaceWithIndicator: state is Loading,
                        margin: EdgeInsets.only(bottom: 40),
                        onTap: onButtonTap,
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
    final addressesProvider = getItInstance<AddressesProvider>();
    if (_formKey.currentState!.validate()) {
      print(phoneController.text);
      Address address = Address(
          isDefault: addressesProvider.addresses.isEmpty,
          area: areaDropdownValue!,
          buildingNumber: buildingNumberController.text,
          floorNumber: floorNumberController.text,
          name: nameController.text,
          landmarkSign: landMarkController.text,
          streetName: streetNameController.text,
          id: widget.editAddress != null ? widget.editAddress!.id : Uuid().v4(),
          phoneNumber: "+20${TrimUtils.trimEnteredNumber(phoneController.text)}",
          addressDescription: addressDescriptionController.text);
      addressesCubit.addOrEditUserAddress(
          address: address, isEdit: widget.editAddress != null ? true : false);
    }
  }

  areaDropDownButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DropdownButton<String>(
        hint: Text('Press to choose area'),
        isExpanded: true,
        iconDisabledColor: Colors.grey,
        value: areaDropdownValue,
        icon: Container(),
        iconSize: 24,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 16,
        // style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          // color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            areaDropdownValue = newValue!;
          });
        },
        items: deliveryAreasProvider.deliveryAreas
            .map<DropdownMenuItem<String>>((DeliveryAreaModel value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name!),
          );
        }).toList(),
      ),
    );
  }
}
