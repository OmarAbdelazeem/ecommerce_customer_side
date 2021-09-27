import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:flutter/material.dart';


import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/action_text.dart';

class MyAddressScreen extends StatefulWidget {
  final bool selectAddress;

  MyAddressScreen({this.selectAddress = false});

  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final languageProvider = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Text(widget.selectAddress
              ? languageProvider.getTranslated(context, StringsConstants.selectAddress)!
              : languageProvider.getTranslated(context, StringsConstants.myAddress)!)),
      body: ProviderNotifier(
        child: (AddressesProvider addressesProvider){
          print('from my_address screen ${addressesProvider.addresses}');
           if(addressesProvider.addresses.isEmpty)
            return noAddressesFound();
          else
            return addressesView(addressesProvider.addresses);
        },
      )
    );
  }

  Widget addressesView(List<Address> addresses) {
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
                    "${addresses.length} ${languageProvider.getTranslated(context, StringsConstants.savedAddresses)}",
                    style: AppTextStyles.normalText,
                  ),
                  ActionText(
                    title: languageProvider.getTranslated(context, StringsConstants.addNewTextCapital)!,
                    onTap: addNewAddressFunction,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            ...List<Widget>.generate(addresses.length, (index) {
              return addressCard(
                addresses[index],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget noAddressesFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "No Address Found",
            style: AppTextStyles.normalText,
          ),
          SizedBox(
            height: 20,
          ),
          ActionText(
            title: languageProvider.getTranslated(context, StringsConstants.addNewTextCapital)!,
            onTap: addNewAddressFunction,
          )
        ],
      ),
    );
  }

  Widget addressCard(Address address) {
    return InkWell(
      onTap: () {
        if(widget.selectAddress){
          final addressesProvider = getItInstance<AddressesProvider>();
          addressesProvider.selectedAddress = address;
          routerUtils.pop(context);
          // Navigator.pop(context);
        }else{
          routerUtils.pushNamedRoot(context, Routes.addOrEditAddressScreen,
              arguments: address);
          // Navigator.pushNamed(context, Routes.addOrEditAddressScreen,
          //     arguments: address);
        }

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${address.area} , ${address.streetName}",
              // style: AppTextStyles.normal12Color81819A,
            ),
            address.addressDescription != null &&
                    address.addressDescription!.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(address.addressDescription!),
                    ],
                  )
                : Container(),
            address.buildingNumber != null && address.buildingNumber!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          '${address.buildingNumber! + address.floorNumber! ?? ''}'),
                    ],
                  )
                : Container(),
            address.landmarkSign != null && address.landmarkSign!.isNotEmpty
                ? Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('${address.landmarkSign}'),
                  ],
                )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Text('Phone number : ${address.phoneNumber}'),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }

  addNewAddressFunction() {
    routerUtils.pushNamedRoot(context, Routes.addOrEditAddressScreen,);
    // Navigator.pushNamed(context, Routes.addOrEditAddressScreen,);
  }
}
