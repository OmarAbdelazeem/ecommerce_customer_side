import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/delivery_areas_provider.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(AddressesState.idle());

  final _firestoreRepo = getItInstance<FirestoreRepository>();

  final _addressesProvider = getItInstance<AddressesProvider>();

  MyConnectivity _connectivity = MyConnectivity.instance;

  final deliveryAreasProvider = getItInstance<DeliveryAreasProvider>();

  List<Address> addresses = [];

  addOrEditUserAddress({required Address address, required bool isEdit}) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (hasConnection) {
      emit(AddressesState.loading());
      try {
        await _firestoreRepo.addOrEditUserAddress(address);
        if (_addressesProvider.addresses.isEmpty) {
          _addressesProvider.selectedAddress = address;
        }
        if (isEdit)
          _addressesProvider.editAddress((address));
        else
          _addressesProvider.addAddress((address));

        emit(AddressesState.successful());
      } catch (e) {
        emit(AddressesState.error(e.toString()));
      }
    }
  }

  List<String> _checkOutOfZonesAddresses() {
    List<String> outOfZoneAddressesIds = [];
    List deliveryAreas = deliveryAreasProvider.deliveryAreas;
    addresses.removeWhere((address) {
      bool isFounded = false;

      for (int i = 0; i < deliveryAreas.length; i++) {
        isFounded = deliveryAreas[i].name == address.area;
        if (isFounded) break;
      }

      if (!isFounded) outOfZoneAddressesIds.add(address.id);

      return !isFounded;
    });
    return outOfZoneAddressesIds;
  }

  Future _deleteOutOfZoneAddresses(List<String> outOfZoneAddressesIds) async {
    outOfZoneAddressesIds.forEach((addressId) async {
      await _firestoreRepo.deleteAddress(addressId);
    });
  }

  Future fetchAddresses() async {
    print('fetchAddresses');
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (hasConnection) {
      emit(AddressesState.loading());
      try {
        List documents = await _firestoreRepo.fetchUserAddresses();
        addresses = List<Address>.generate(documents.length,
            (index) => Address.fromDocument(documents[index]));

        List<String> outOfZoneAddressesIds = [];

        outOfZoneAddressesIds = _checkOutOfZonesAddresses();

        await _deleteOutOfZoneAddresses(outOfZoneAddressesIds);

        _addressesProvider.setAddresses = addresses;

        var defaultAddress =
            (addresses.where((element) => element.isDefault == true)).toList();

        if (defaultAddress.isNotEmpty)
          _addressesProvider.selectedAddress = defaultAddress[0];
        emit(AddressesState.loaded(addresses));

      } catch (e) {
        print(e);
      }
    }
  }
}
