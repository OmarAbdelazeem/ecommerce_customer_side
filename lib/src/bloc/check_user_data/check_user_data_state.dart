import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_user_data_state.freezed.dart';

@freezed
abstract class CheckUserDataState {
  const factory CheckUserDataState.idle() = Idle;

  const factory CheckUserDataState.loading() = Loading;

  const factory CheckUserDataState.userDataNotFound() = UserDataNotFound;

  const factory CheckUserDataState.finished() = Finished;
  const factory CheckUserDataState.connectionError() = ConnectionError;


}
