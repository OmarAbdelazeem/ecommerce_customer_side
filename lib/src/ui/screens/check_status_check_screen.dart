import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/navigation_provider.dart';
import 'package:baqal/src/ui/screens/add_user_detail_screen.dart';
import 'package:baqal/src/ui/screens/main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

class CheckStatusScreen extends StatefulWidget {
  final bool checkForAccountStatusOnly;

  CheckStatusScreen({this.checkForAccountStatusOnly = false});

  @override
  _CheckStatusScreenState createState() => _CheckStatusScreenState();
}

class _CheckStatusScreenState extends State<CheckStatusScreen> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        ),
      ),
    );
  }

  void checkStatus() async {
    var repo = getItInstance<FirebaseRepository>();
    var firebaseRepo = getItInstance<FirestoreRepository>();

    Future.delayed(Duration(seconds: widget.checkForAccountStatusOnly ? 2 : 0),
        () async {
      var status = await repo.checkUserLoggedInStatus();

      if (widget.checkForAccountStatusOnly || status) {

        var userData = await firebaseRepo.checkUserDetail();
        if (userData != null) {
          print('user data not equal null');
          var accountProvider = getItInstance<AccountProvider>();

          AccountDetails accountDetails = AccountDetails.fromDocument(userData);
          accountDetails.addresses = accountDetails.addresses!.reversed.toList();
          accountProvider.addressSelected = (accountDetails.addresses!.isNotEmpty ? accountDetails.addresses![0]:null)!;
          accountProvider.accountDetails = accountDetails;

          accountProvider.user = await repo.getCurrentUser();
          Address ? address;
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

          final navigationProvider = getItInstance<NavigationProvider>();
         if(navigationProvider.getPushingPageRoot ==null){
           print('mainHomeScreen condition is true -----------------------------++++++++++');
           Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute<void>(builder: (BuildContext context) =>  MainHomeScreen()),
                 (route) => false,
           );
         }
         else{
           print('mainHomeScreen condition is false -----------------------------++++++++++');
           Navigator.of(context)
               .popUntil(ModalRoute.withName(navigationProvider.getPushingPageRoot));
         }

        }
        else {
          Navigator.pushReplacement(context , MaterialPageRoute<void>(builder: (_) =>  AddUserDetailScreen(true)));
        }
      } else {
        Navigator.pushReplacement(context , MaterialPageRoute<void>(builder: (_) =>  MainHomeScreen()));
      }
    });
  }

}
