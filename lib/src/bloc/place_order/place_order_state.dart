import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_order_state.freezed.dart';

@freezed
abstract class PlaceOrderState with _$PlaceOrderState {
  const factory PlaceOrderState.idle() = Idle;

  const factory PlaceOrderState.loading() = Loading;

  const factory PlaceOrderState.orderCanceled() = OrderCanceled;

  const factory PlaceOrderState.orderSuccessfullyPlaced() =
      OrderSuccessfullyPlaced;

  const factory PlaceOrderState.error(String message) = Error;
}
