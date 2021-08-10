import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_address/add_address.dart';
import 'package:baqal/src/bloc/add_address/add_address_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  var _firebaseRepo = getItInstance<FirestoreRepository>();
  var _authRepo = getItInstance<FirebaseRepository>();
  final accountProvider = getItInstance<AccountProvider>();
  AddAddressCubit() : super(AddAddressState.idle());

  saveAddress(Address address) {
    emit(AddAddressState.buttonLoading());

    _firebaseRepo.addUserAddress(address).then((value) {
      emit(AddAddressState.successful());
    }).catchError((e) {
      emit(AddAddressState.error(e.toString()));
    });
  }
}
