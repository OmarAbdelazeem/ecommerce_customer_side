import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/validator.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'account_details_state.dart';

class AccountDetailsCubit extends Cubit<AccountDetailsState> {
  final _firestoreRepo = getItInstance<FirestoreRepository>();
  final _authRepo = getItInstance<FirebaseRepository>();
  final _accountProvider = getItInstance<AccountProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  Validator _validator = Validator();
  MyConnectivity _connectivity = MyConnectivity.instance;

  AccountDetailsCubit() : super(AccountDetailsState.idle());

  validateEditNameButton(String name) {
    if (_validator.validateNameFunction(name) == null) {
      emit(AccountDetailsState.onButtonEnabled());
    } else
      emit(AccountDetailsState.onButtonDisabled());
  }

  saveData(String name, bool isEdit) async {
    bool hasConnection = await _connectivity.checkInternetConnection();

    if (hasConnection) {
      emit(AccountDetailsState.loading());
      try {
        User? user = await _authRepo.getCurrentUser();
        AccountDetails _accountDetails = AccountDetails();
        _accountDetails.name = name;
        _accountDetails.phoneNumber = user!.phoneNumber;
        _accountDetails.id = user.uid;
        _accountDetails.language = languageProvider.locale!.languageCode;
        _accountDetails.token = await FirebaseMessaging.instance.getToken();
        _accountProvider.accountDetails = _accountDetails;

        if (isEdit) {
          await _firestoreRepo.updateCustomerField({'name': name}, user.uid);
        } else {
          await _firestoreRepo.addUserDetails(_accountDetails);
        }
        emit(AccountDetailsState.successful());
      } catch (e) {
        print(e);
      }
    }
  }

  Future updatePhoneNumber(String phoneNumber) async {
    try {
      User? user = await _authRepo.getCurrentUser();
      print('getCurrentUser is $user');
      await _firestoreRepo
          .updateCustomerField({'phone_number': phoneNumber}, user!.uid);
      _accountProvider.phoneNumber = phoneNumber;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future updateToken(String token) async {
    try {
      await _firestoreRepo
          .updateCustomerField({'token': token}, _accountProvider.user!.uid);
    } catch (e) {
      print(e);
    }
  }

  Future updateLanguage(String languageCode) async {
    try {
      await _firestoreRepo.updateCustomerField(
          {'language': languageCode}, _accountProvider.user!.uid);
    } catch (e) {
      print(e);
    }
  }
}
