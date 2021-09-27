import 'package:baqal/src/models/banner_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'banners_state.freezed.dart';

@freezed
abstract class BannersState with _$BannersState{
  const factory BannersState.idle() = Idle;

  const factory BannersState.loading() = Loading;
  const factory BannersState.error(String error) = Error;

  const factory BannersState.loaded(List<BannerModel> banners) = Loaded;

}

