import 'package:baqal/src/models/account_details_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part  'addresses_state.freezed.dart';

@freezed
abstract class AddressesState with _$AddressesState{
  const factory AddressesState.idle() = Idle;
  const factory AddressesState.loading() = Loading;
  const factory AddressesState.loaded(List<Address> addresses) = Loaded;
  const factory AddressesState.successful() = Successful;
  const factory AddressesState.error(String error) = Error;

}

