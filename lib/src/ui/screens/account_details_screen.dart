import 'package:auto_route/annotations.dart';
import 'package:baqal/src/app.dart';
import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/screens/my_orders_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_user_detail_screen.dart';
import 'my_address_screen.dart';

class AccountDetailsScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AccountDetailsScreen> {
  AuthCubit _authCubit =getItInstance<AuthCubit>();
  var accountProvider = getItInstance<AccountProvider>();
  var firebaseRepo = getItInstance<FirestoreRepository>();
  var authRepo = getItInstance<FirebaseRepository>();
  bool isLoaded = false;

  @override
  void initState() {
    // listenToAccountDetails();
    // TODO: implement initState
    super.initState();
  }

  void listenToAccountDetails() async {
    firebaseRepo.streamUserDetails(await authRepo.getUid()).listen((event) {
      AccountDetails accountDetails = AccountDetails.fromDocument(event);
      accountDetails.addresses = accountDetails.addresses!.reversed.toList();

      Address? address;
      List.generate(accountDetails.addresses!.length, (index) {
        Address add = accountDetails.addresses![index];
        if (add.isDefault) {
          address = add;
        }
      });
      if (address == null && accountDetails.addresses!.isNotEmpty) {
        address = accountDetails.addresses![0];
        accountProvider.addressSelected = address!;
      } else {
        accountProvider.addressSelected = address!;
      }
      accountProvider.accountDetails = accountDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = getItInstance<AccountProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: accountProvider.accountDetails != null
          ? SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProviderNotifier(
                    child: (AccountProvider value){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade300,
                                child: Text(value.accountDetails.name![0],style: TextStyle(fontSize: 40,color: Colors.black,fontWeight:FontWeight.w200 ),),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: 16, right: 16, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  value.accountDetails.name!,
                                                  style: AppTextStyles
                                                      .medium22Black,
                                                ),
                                                IconButton(
                                                    icon: Icon(Icons.mode_edit,color: Colors.grey.shade400,),
                                                    onPressed: () {
                                                      Navigation.push(context, AddUserDetailScreen(false ));
                                                    })
                                              ],
                                            ),
                                            Text(
                                              value.accountDetails.phoneNumber!,
                                              style: AppTextStyles
                                                  .normal14Color4C4C6F,
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
                          ListTile(
                            title: Text(StringsConstants.myOrders),
                            leading: Icon(Icons.shopping_basket),
                            onTap: () {
                              Navigation.push(context, MyOrdersScreen());
                            },
                          ),
                          ListTile(
                            title: Text(StringsConstants.myAddress),
                            leading: Icon(Icons.place),
                            onTap: () {
                              Navigation.push(context, MyAddressScreen());
                            },
                          ),
                          ListTile(
                            title: Text('Change Password'),
                            leading: Icon(Icons.lock),
                            onTap: () {

                            },
                          ),

                          Divider(),
                          ListTile(
                            title: Text(StringsConstants.logout),
                            leading: Icon(Icons.exit_to_app),
                            onTap: () {
                              _authCubit.logout();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
