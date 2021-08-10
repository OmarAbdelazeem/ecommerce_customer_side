import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/ui/screens/add_address_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/address_card/address_card.dart';
import 'package:baqal/src/bloc/address_card/address_card_state.dart';

import 'package:baqal/src/bloc/my_address/my_address.dart' as my_address;
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/action_text.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';

class MyAddressScreen extends StatefulWidget {
  final bool selectedAddress;

  MyAddressScreen({this.selectedAddress = false});

  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  my_address.MyAddressCubit myAddressCubit = getItInstance<my_address.MyAddressCubit>();

  @override
  void initState() {
    super.initState();
    myAddressCubit.listenToAccountDetails();
    myAddressCubit.fetchAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Text(widget.selectedAddress
              ? StringsConstants.selectAddress
              : StringsConstants.myAddress)),
      body: BlocConsumer<my_address.MyAddressCubit, my_address.MyAddressState>(
        bloc: myAddressCubit,
        listener: (BuildContext context, my_address.MyAddressState state) {},
        builder: (BuildContext context, my_address.MyAddressState state) {
          return state.map(showAccountDetails: (my_address.ShowAccountDetails value) {
            if (value.accountDetails.addresses!.isEmpty) {
              return noAddressesFound(value.accountDetails);
            }
            return addressesView(value.accountDetails);
          }, loading: (my_address.Loading value) {
            return Center(
              child: CommonAppLoader(),
            );
          }, error: (value) {
            return Text(value.errorMessage);
          });
        },
      ),
    );
  }

  Widget addressesView(AccountDetails accountDetails) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 22,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${accountDetails.addresses!.length} ${StringsConstants.savedAddresses}",
                    style: AppTextStyles.medium12Color81819A,
                  ),
                  ActionText(
                    title: StringsConstants.addNewCaps,
                    onTap: () {
                      addNewNavigation(accountDetails);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            ...List<Widget>.generate(accountDetails.addresses!.length, (index) {
              return addressCard(accountDetails, index);
            })
          ],
        ),
      ),
    );
  }

  Widget addressCard(AccountDetails accountDetails, index) {
    var addressCardCubit = getItInstance<AddressCardCubit>();
    Address address = accountDetails.addresses![index];
    Widget data(IconData iconData, String text) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: AppColors.color81819A,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
              child: Text(
            "$text",
            style: AppTextStyles.normal12Color81819A,
          ))
        ],
      );
    }

    return BlocConsumer<AddressCardCubit, AddressCardState>(
      bloc: addressCardCubit,
      listener: (context, state) {
        state.when(
            successful: () {
              myAddressCubit.fetchAccountDetails();
            },
            editLoading: () {},
            error: (_) {},
            idle: () {},
            setDefaultLoading: () {});
      },
      builder: (BuildContext context, AddressCardState state) {
        return Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: InkWell(
              onTap: widget.selectedAddress
                  ? () {
                      var accountProvider = getItInstance<AccountProvider>();
                      accountProvider.addressSelected =
                          accountDetails.addresses![index];
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            address.name,
                            style: AppTextStyles.medium14Black,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 20,
                            width: address.isDefault ? null : 0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.color6EBA49,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              StringsConstants.defaultCaps,
                              style: AppTextStyles.medium14White,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      data(Icons.phone, address.phoneNumber),
                      SizedBox(
                        height: 23,
                      ),
                      data(Icons.place,
                          "${address.address} ${address.city} ${address.state}"),
                      SizedBox(
                        height: 33,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ActionText(
                               title:  StringsConstants.editCaps,
                                onTap: () {
                                 Navigation.push(context, AddAddressScreen(false ,editAddress: address,))
                                      .then((value) {
                                    if (value != null &&
                                        value is bool &&
                                        value) {
                                      myAddressCubit.fetchAccountDetails();
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              state is EditLoading
                                  ? CommonAppLoader(
                                      size: 20,
                                    )
                                  : ActionText(
                                      title: StringsConstants.deleteCaps,
                                      onTap: () {
                                        addressCardCubit.deleteAddress(
                                            accountDetails, address);
                                      },
                                    ),
                            ],
                          ),
                          Visibility(
                            visible: !address.isDefault,
                            child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: state is SetDefaultLoading
                                    ? CommonAppLoader(
                                        size: 20,
                                      )
                                    : ActionText(
                                        title: StringsConstants.setAsDefaultCaps,
                                        onTap: () {
                                          addressCardCubit.setAsDefault(
                                              accountDetails, index);
                                        },
                                      )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget noAddressesFound(AccountDetails accountDetails) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "No Address Found",
            style: AppTextStyles.medium18Black,
          ),
          SizedBox(
            height: 20,
          ),
          ActionText(
            title: StringsConstants.addNewCaps,
            onTap: () {
              addNewNavigation(accountDetails);
            },
          )
        ],
      ),
    );
  }

  addNewNavigation(AccountDetails accountDetails) {
    Navigation.push(context, AddAddressScreen(true)).then((value) {
      if (value != null && value is bool && value) {
        myAddressCubit.fetchAccountDetails();
      }
    });
  }
}
