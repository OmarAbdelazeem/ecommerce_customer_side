import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/my_address/my_address.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

class MyAddressCubit extends Cubit<MyAddressState> {
  var firebaseRepo = getItInstance<FirestoreRepository>();
  var authRepo = getItInstance<FirebaseRepository>();

  MyAddressCubit() : super(MyAddressState.loading());

  listenToAccountDetails() async {
    firebaseRepo.streamUserDetails(await authRepo.getUid()).listen((event) {
      AccountDetails accountDetails = AccountDetails.fromDocument(event);
      accountDetails.addresses = accountDetails.addresses!.reversed.toList();
      emit(MyAddressState.showAccountDetails(accountDetails));
    });
  }

  fetchAccountDetails() async {
    try {
      AccountDetails accountDetails = await firebaseRepo.fetchUserDetails();
      accountDetails.addresses = accountDetails.addresses!.reversed.toList();
      emit(MyAddressState.showAccountDetails(accountDetails));
    } catch (e) {
      emit(MyAddressState.error(e.toString()));
    }
  }
}
