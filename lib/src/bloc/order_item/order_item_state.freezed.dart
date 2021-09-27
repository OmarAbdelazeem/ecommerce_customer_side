// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OrderItemStateTearOff {
  const _$OrderItemStateTearOff();

  Idle idle() {
    return const Idle();
  }

  Loading loading() {
    return const Loading();
  }

  StatusLoading statusLoading() {
    return const StatusLoading();
  }

  StatusLoaded statusLoaded(String status) {
    return StatusLoaded(
      status,
    );
  }

  Loaded loaded(OrderModel order) {
    return Loaded(
      order,
    );
  }

  Error error(String error) {
    return Error(
      error,
    );
  }
}

/// @nodoc
const $OrderItemState = _$OrderItemStateTearOff();

/// @nodoc
mixin _$OrderItemState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemStateCopyWith<$Res> {
  factory $OrderItemStateCopyWith(
          OrderItemState value, $Res Function(OrderItemState) then) =
      _$OrderItemStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$OrderItemStateCopyWithImpl<$Res>
    implements $OrderItemStateCopyWith<$Res> {
  _$OrderItemStateCopyWithImpl(this._value, this._then);

  final OrderItemState _value;
  // ignore: unused_field
  final $Res Function(OrderItemState) _then;
}

/// @nodoc
abstract class $IdleCopyWith<$Res> {
  factory $IdleCopyWith(Idle value, $Res Function(Idle) then) =
      _$IdleCopyWithImpl<$Res>;
}

/// @nodoc
class _$IdleCopyWithImpl<$Res> extends _$OrderItemStateCopyWithImpl<$Res>
    implements $IdleCopyWith<$Res> {
  _$IdleCopyWithImpl(Idle _value, $Res Function(Idle) _then)
      : super(_value, (v) => _then(v as Idle));

  @override
  Idle get _value => super._value as Idle;
}

/// @nodoc

class _$Idle implements Idle {
  const _$Idle();

  @override
  String toString() {
    return 'OrderItemState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Idle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class Idle implements OrderItemState {
  const factory Idle() = _$Idle;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$OrderItemStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc

class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'OrderItemState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements OrderItemState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $StatusLoadingCopyWith<$Res> {
  factory $StatusLoadingCopyWith(
          StatusLoading value, $Res Function(StatusLoading) then) =
      _$StatusLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$StatusLoadingCopyWithImpl<$Res>
    extends _$OrderItemStateCopyWithImpl<$Res>
    implements $StatusLoadingCopyWith<$Res> {
  _$StatusLoadingCopyWithImpl(
      StatusLoading _value, $Res Function(StatusLoading) _then)
      : super(_value, (v) => _then(v as StatusLoading));

  @override
  StatusLoading get _value => super._value as StatusLoading;
}

/// @nodoc

class _$StatusLoading implements StatusLoading {
  const _$StatusLoading();

  @override
  String toString() {
    return 'OrderItemState.statusLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is StatusLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) {
    return statusLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) {
    return statusLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (statusLoading != null) {
      return statusLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return statusLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) {
    return statusLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (statusLoading != null) {
      return statusLoading(this);
    }
    return orElse();
  }
}

abstract class StatusLoading implements OrderItemState {
  const factory StatusLoading() = _$StatusLoading;
}

/// @nodoc
abstract class $StatusLoadedCopyWith<$Res> {
  factory $StatusLoadedCopyWith(
          StatusLoaded value, $Res Function(StatusLoaded) then) =
      _$StatusLoadedCopyWithImpl<$Res>;
  $Res call({String status});
}

/// @nodoc
class _$StatusLoadedCopyWithImpl<$Res>
    extends _$OrderItemStateCopyWithImpl<$Res>
    implements $StatusLoadedCopyWith<$Res> {
  _$StatusLoadedCopyWithImpl(
      StatusLoaded _value, $Res Function(StatusLoaded) _then)
      : super(_value, (v) => _then(v as StatusLoaded));

  @override
  StatusLoaded get _value => super._value as StatusLoaded;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(StatusLoaded(
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StatusLoaded implements StatusLoaded {
  const _$StatusLoaded(this.status);

  @override
  final String status;

  @override
  String toString() {
    return 'OrderItemState.statusLoaded(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StatusLoaded &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(status);

  @JsonKey(ignore: true)
  @override
  $StatusLoadedCopyWith<StatusLoaded> get copyWith =>
      _$StatusLoadedCopyWithImpl<StatusLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) {
    return statusLoaded(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) {
    return statusLoaded?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (statusLoaded != null) {
      return statusLoaded(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return statusLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) {
    return statusLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (statusLoaded != null) {
      return statusLoaded(this);
    }
    return orElse();
  }
}

abstract class StatusLoaded implements OrderItemState {
  const factory StatusLoaded(String status) = _$StatusLoaded;

  String get status => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusLoadedCopyWith<StatusLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadedCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) then) =
      _$LoadedCopyWithImpl<$Res>;
  $Res call({OrderModel order});
}

/// @nodoc
class _$LoadedCopyWithImpl<$Res> extends _$OrderItemStateCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(Loaded _value, $Res Function(Loaded) _then)
      : super(_value, (v) => _then(v as Loaded));

  @override
  Loaded get _value => super._value as Loaded;

  @override
  $Res call({
    Object? order = freezed,
  }) {
    return _then(Loaded(
      order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
    ));
  }
}

/// @nodoc

class _$Loaded implements Loaded {
  const _$Loaded(this.order);

  @override
  final OrderModel order;

  @override
  String toString() {
    return 'OrderItemState.loaded(order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loaded &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(order);

  @JsonKey(ignore: true)
  @override
  $LoadedCopyWith<Loaded> get copyWith =>
      _$LoadedCopyWithImpl<Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) {
    return loaded?.call(order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements OrderItemState {
  const factory Loaded(OrderModel order) = _$Loaded;

  OrderModel get order => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadedCopyWith<Loaded> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$OrderItemStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Error implements Error {
  const _$Error(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'OrderItemState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() statusLoading,
    required TResult Function(String status) statusLoaded,
    required TResult Function(OrderModel order) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? statusLoading,
    TResult Function(String status)? statusLoaded,
    TResult Function(OrderModel order)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(StatusLoading value) statusLoading,
    required TResult Function(StatusLoaded value) statusLoaded,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(StatusLoading value)? statusLoading,
    TResult Function(StatusLoaded value)? statusLoaded,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements OrderItemState {
  const factory Error(String error) = _$Error;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
