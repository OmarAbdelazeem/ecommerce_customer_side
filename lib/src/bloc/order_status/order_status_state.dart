
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_status_state.freezed.dart';

@freezed
abstract class OrderStatusState with _$OrderStatusState{
  const factory OrderStatusState.idle() = Idle;
  const factory OrderStatusState.loaded(String status) = Loaded;
  const factory OrderStatusState.loading() = Loading;

}

