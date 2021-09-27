import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_connection_state.freezed.dart';

@freezed
abstract class InternetConnectionState with _$InternetConnectionState {
  const factory InternetConnectionState.idle() = Idle;

  const factory InternetConnectionState.noInternetConnection() =
      NoInternetConnection;

  const factory InternetConnectionState.connectedSuccessfully() =
      ConnectedSuccessfully;
}
