import 'package:baqal/src/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_state.freezed.dart';

@freezed
abstract class OrderItemState with _$OrderItemState {
  const factory OrderItemState.idle() = Idle;

  const factory OrderItemState.loading() = Loading;

  const factory OrderItemState.statusLoading() = StatusLoading;

  const factory OrderItemState.statusLoaded(String status) = StatusLoaded;

  const factory OrderItemState.loaded(OrderModel order) = Loaded;

  const factory OrderItemState.error(String error) = Error;
}
