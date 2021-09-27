import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:baqal/src/models/account_details_model.dart';

part 'account_details_state.freezed.dart';

@freezed
abstract class AccountDetailsState with _$AccountDetailsState {
  const factory AccountDetailsState.idle() = Idle;

  const factory AccountDetailsState.editData(AccountDetails accountDetails) =
      EditData;

  const factory AccountDetailsState.loading() = Loading;

  const factory AccountDetailsState.onButtonEnabled() = ButtonEnabled;

  const factory AccountDetailsState.onButtonDisabled() = ButtonDisabled;

  const factory AccountDetailsState.addressesLoaded(List<Address> addresses) = AddressesLoaded;

  const factory AccountDetailsState.successful() = Successful;

  const factory AccountDetailsState.error(String error) = Error;

}
