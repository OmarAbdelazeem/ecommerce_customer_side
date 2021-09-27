import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:baqal/src/models/account_details_model.dart';

class AccountProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool ? _lastConnectionStatus = false;

  set setLastConnectionStatus(bool val){
    _lastConnectionStatus = val;
  }
  get lastConnectionStatus => _lastConnectionStatus;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  AccountDetails? _accountDetails;

  AccountDetails? get accountDetails => _accountDetails;

  set accountDetails(AccountDetails? value) {
    _accountDetails = value;
    notifyListeners();
  }

  set phoneNumber(String phoneNumber){
    _accountDetails!.phoneNumber = phoneNumber;
    notifyListeners();
  }

}
