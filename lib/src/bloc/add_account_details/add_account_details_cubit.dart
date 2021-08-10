import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_account_details/add_account_details.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'add_account_details_state.dart';
class AddAccountDetailsCubit extends Cubit<AddAccountDetailsState> {
  final _firebaseRepo = getItInstance<FirestoreRepository>();
  final _authRepo = getItInstance<FirebaseRepository>();

  Validator _validator = Validator();

  AddAccountDetailsCubit() : super(AddAccountDetailsState.idle());
late  AccountDetails _accountDetails;

  validateButton(String name) {
    if (_validator.validateNameFunction(name) == null) {
      emit(AddAccountDetailsState.onButtonEnabled());
    } else
      emit(AddAccountDetailsState.onButtonDisabled());
  }

  loadPreviousData() async {
    emit(AddAccountDetailsState.loading());
    _accountDetails = await _firebaseRepo.fetchUserDetails();
    emit(AddAccountDetailsState.editData(_accountDetails));
    validateButton(_accountDetails.name!);
  }

  saveData(String name, {bool isEdit = false}) async {
    if (isEdit) {
      _accountDetails = AccountDetails();
    }
    _accountDetails.name = name;
    _accountDetails.phoneNumber = await _authRepo.getPhoneNumber();
    final accountProvider = getItInstance<AccountProvider>();
    accountProvider.accountDetails = _accountDetails;
    emit(AddAccountDetailsState.saveDataLoading());
    await _firebaseRepo.addUserDetails(_accountDetails);
    await _authRepo.setAccountDetails(displayName: _accountDetails.name!);
    emit(AddAccountDetailsState.successful());
  }
}
