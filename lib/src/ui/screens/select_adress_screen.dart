import 'package:baqal/src/bloc/address_card/address_card.dart';
import 'package:baqal/src/bloc/address_card/address_card_state.dart';
import 'package:baqal/src/bloc/my_address/my_address.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAddressScreen extends StatefulWidget {

  final bool selectedAddress;

  SelectAddressScreen({this.selectedAddress = false});
  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  MyAddressCubit myAddressCubit = getItInstance<MyAddressCubit>();
  final addressProvider = getItInstance<AccountProvider>();

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
        title: Text('Select address'),
        actions: [FlatButton(onPressed: () {}, child: Text('Add'))],
      ),
      body: BlocConsumer<MyAddressCubit, MyAddressState>(
        bloc: myAddressCubit,
        listener: (BuildContext context, MyAddressState state) {},
        builder: (BuildContext context, MyAddressState state) {
          return state.map(showAccountDetails: (ShowAccountDetails value) {
            // if (value.accountDetails.addresses.isEmpty) {
            //   return noAddressesFound(value.accountDetails);
            // }
            return addressesView(value.accountDetails);
          }, loading: (Loading value) {
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
            // SizedBox(
            //   height: 22,
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "${accountDetails.addresses.length} ${StringsConstants.savedAddresses}",
            //         style: AppTextStyles.medium12Color81819A,
            //       ),
            //       // ActionText(
            //       //   StringsConstants.addNewCaps,
            //       //   onTap: () {
            //       //     // addNewNavigation(accountDetails);
            //       //   },
            //       // )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 21,
            // ),
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

    return GestureDetector(
      onTap: (){
        addressProvider.addressSelected = address;
        Navigator.pop(context);
      },
      child: BlocConsumer<AddressCardCubit, AddressCardState>(
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
                // onTap:
                // widget.selectedAddress
                //     ? () {
                //   var accountProvider = AppInjector.get<AccountProvider>();
                //   accountProvider.addressSelected =
                //   accountDetails.addresses[index];
                //   Navigator.of(context).pop();
                // }
                //     : null,
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
                        // SizedBox(
                        //   height: 33,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         ActionText(
                        //           StringsConstants.editCaps,
                        //           onTap: () {
                        //             Navigator.pushNamed(
                        //                 context, Routes.addAddressScreen,
                        //                 arguments: AddAddressScreenArguments(
                        //                     newAddress: false,
                        //                     accountDetails: accountDetails,
                        //                     editAddress: address))
                        //                 .then((value) {
                        //               if (value != null &&
                        //                   value is bool &&
                        //                   value) {
                        //                 myAddressCubit.fetchAccountDetails();
                        //               }
                        //             });
                        //           },
                        //         ),
                        //         SizedBox(
                        //           width: 30,
                        //         ),
                        //         state is EditLoading
                        //             ? CommonAppLoader(
                        //           size: 20,
                        //         )
                        //             : ActionText(
                        //           StringsConstants.deleteCaps,
                        //           onTap: () {
                        //             addressCardCubit.deleteAddress(
                        //                 accountDetails, address);
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        //     // Visibility(
                        //     //   visible: !address.isDefault,
                        //     //   child: Container(
                        //     //       margin: EdgeInsets.only(left: 20),
                        //     //       child: state is SetDefaultLoading
                        //     //           ? CommonAppLoader(
                        //     //         size: 20,
                        //     //       )
                        //     //           : ActionText(
                        //     //         StringsConstants.setAsDefaultCaps,
                        //     //         onTap: () {
                        //     //           addressCardCubit.setAsDefault(
                        //     //               accountDetails, index);
                        //     //         },
                        //     //       )),
                        //     // )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

}
