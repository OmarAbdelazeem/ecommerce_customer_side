import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'check_user_data_state.dart';

class CheckUserDataCubit extends Cubit<CheckUserDataState> {
  CheckUserDataCubit() : super(CheckUserDataState.idle());
  var _firebaseRepo = getItInstance<FirebaseRepository>();
  var _firestoreRepo = getItInstance<FirestoreRepository>();
  var _accountProvider = getItInstance<AccountProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;

  // main functionality is that user is logged in or not
  // if logged in check that have data or not
  // if user is null or not he must navigate to main screen

  Future checkUserData() async {
    bool hasConnection = await _connectivity.checkInternetConnection();

    emit(CheckUserDataState.loading());

    if (!hasConnection) {
      emit(CheckUserDataState.connectionError());
    } else {
      try {
        /// 1 - get current user
        var currentUser = await _firebaseRepo.getCurrentUser();
        print('current user is $currentUser');
        if (currentUser != null) {
          // 1- save current user in account notifier
          _accountProvider.user = currentUser;

          // 2- get user data
          var userData = await _firestoreRepo.getUserData(currentUser.uid);
          print('userData is $userData');
          if (userData != null) {
            // 1- save data in account notifier
            _accountProvider.accountDetails =
                AccountDetails.fromDocument(userData);
            _accountProvider.setLastConnectionStatus = true;
            // 2- navigate to homeScreen
          }
          // if customer does not have data then navigate to addNameScreen
          else {
            emit(CheckUserDataState.userDataNotFound());
            return;
          }
        }
      } catch (e) {
        print(e);
      }
      emit(CheckUserDataState.finished());
    }
  }


}
