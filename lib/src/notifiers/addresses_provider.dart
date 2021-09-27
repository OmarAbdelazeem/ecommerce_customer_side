import 'package:baqal/src/models/account_details_model.dart';
import 'package:flutter/cupertino.dart';

class AddressesProvider with ChangeNotifier {
  Address? _selectedAddress;

  Address? get selectedAddress => _selectedAddress;

  set selectedAddress(Address? address) {
    _selectedAddress = address;
    notifyListeners();
  }

  List<Address> _addresses = [];

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  void editAddress(Address editedAddress) {
    int index =
        _addresses.indexWhere((element) => element.id == editedAddress.id);
    print('index is $index');
    _addresses[index] = editedAddress;
    if (_selectedAddress != null) {
      if (_selectedAddress!.id == editedAddress.id) {
        _selectedAddress = editedAddress;
      }
    }
    notifyListeners();
  }

  set setAddresses(List<Address> addresses) {
    _addresses = addresses;
    notifyListeners();
  }

  List<Address> get addresses => _addresses;
}
