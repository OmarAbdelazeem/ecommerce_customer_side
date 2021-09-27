import 'package:baqal/src/models/delivery_area.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_areas_state.freezed.dart';

@freezed
abstract class DeliveryAreasState with _$DeliveryAreasState {
  const factory DeliveryAreasState.idle() = Idle;

  const factory DeliveryAreasState.loading() = Loading;

  const factory DeliveryAreasState.loaded(List<DeliveryAreaModel> cities) = Loaded;
}
