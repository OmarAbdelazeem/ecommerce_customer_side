import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:baqal/src/models/account_details_model.dart';

class AccountProvider with ChangeNotifier {
  User ? _user;

  User ?  get user => _user;

  set user(User ? value) {
    _user = value;
    notifyListeners();
  }

  AccountDetails ? _accountDetails;

  AccountDetails get accountDetails => _accountDetails!;

  set accountDetails(AccountDetails value) {
    _accountDetails = value;
    notifyListeners();
  }

  Address ? _addressSelected;

  Address get addressSelected => _addressSelected!;

  set addressSelected(Address value) {
    _addressSelected = value;
    notifyListeners();
  }
}
