// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'place_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlaceOrderStateTearOff {
  const _$PlaceOrderStateTearOff();

  Idle idle() {
    return const Idle();
  }

  Loading loading() {
    return const Loading();
  }

  OrderCanceled orderCanceled() {
    return const OrderCanceled();
  }

  OrderSuccessfullyPlaced orderSuccessfullyPlaced() {
    return const OrderSuccessfullyPlaced();
  }

  Error error(String message) {
    return Error(
      message,
    );
  }
}

/// @nodoc
const $PlaceOrderState = _$PlaceOrderStateTearOff();

/// @nodoc
mixin _$PlaceOrderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() orderCanceled,
    required TResult Function() orderSuccessfullyPlaced,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(OrderCanceled value) orderCanceled,
    required TResult Function(OrderSuccessfullyPlaced value)
        orderSuccessfullyPlaced,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceOrderStateCopyWith<$Res> {
  factory $PlaceOrderStateCopyWith(
          PlaceOrderState value, $Res Function(PlaceOrderState) then) =
      _$PlaceOrderStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PlaceOrderStateCopyWithImpl<$Res>
    implements $PlaceOrderStateCopyWith<$Res> {
  _$PlaceOrderStateCopyWithImpl(this._value, this._then);

  final PlaceOrderState _value;
  // ignore: unused_field
  final $Res Function(PlaceOrderState) _then;
}

/// @nodoc
abstract class $IdleCopyWith<$Res> {
  factory $IdleCopyWith(Idle value, $Res Function(Idle) then) =
      _$IdleCopyWithImpl<$Res>;
}

/// @nodoc
class _$IdleCopyWithImpl<$Res> extends _$PlaceOrderStateCopyWithImpl<$Res>
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
    return 'PlaceOrderState.idle()';
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
    required TResult Function() orderCanceled,
    required TResult Function() orderSuccessfullyPlaced,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
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
    required TResult Function(OrderCanceled value) orderCanceled,
    required TResult Function(OrderSuccessfullyPlaced value)
        orderSuccessfullyPlaced,
    required TResult Function(Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class Idle implements PlaceOrderState {
  const factory Idle() = _$Idle;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$PlaceOrderStateCopyWithImpl<$Res>
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
    return 'PlaceOrderState.loading()';
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
    required TResult Function() orderCanceled,
    required TResult Function() orderSuccessfullyPlaced,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
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
    required TResult Function(OrderCanceled value) orderCanceled,
    required TResult Function(OrderSuccessfullyPlaced value)
        orderSuccessfullyPlaced,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements PlaceOrderState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $OrderCanceledCopyWith<$Res> {
  factory $OrderCanceledCopyWith(
          OrderCanceled value, $Res Function(OrderCanceled) then) =
      _$OrderCanceledCopyWithImpl<$Res>;
}

/// @nodoc
class _$OrderCanceledCopyWithImpl<$Res>
    extends _$PlaceOrderStateCopyWithImpl<$Res>
    implements $OrderCanceledCopyWith<$Res> {
  _$OrderCanceledCopyWithImpl(
      OrderCanceled _value, $Res Function(OrderCanceled) _then)
      : super(_value, (v) => _then(v as OrderCanceled));

  @override
  OrderCanceled get _value => super._value as OrderCanceled;
}

/// @nodoc

class _$OrderCanceled implements OrderCanceled {
  const _$OrderCanceled();

  @override
  String toString() {
    return 'PlaceOrderState.orderCanceled()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is OrderCanceled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() orderCanceled,
    required TResult Function() orderSuccessfullyPlaced,
    required TResult Function(String message) error,
  }) {
    return orderCanceled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
  }) {
    return orderCanceled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (orderCanceled != null) {
      return orderCanceled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(OrderCanceled value) orderCanceled,
    required TResult Function(OrderSuccessfullyPlaced value)
        orderSuccessfullyPlaced,
    required TResult Function(Error value) error,
  }) {
    return orderCanceled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
  }) {
    return orderCanceled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (orderCanceled != null) {
      return orderCanceled(this);
    }
    return orElse();
  }
}

abstract class OrderCanceled implements PlaceOrderState {
  const factory OrderCanceled() = _$OrderCanceled;
}

/// @nodoc
abstract class $OrderSuccessfullyPlacedCopyWith<$Res> {
  factory $OrderSuccessfullyPlacedCopyWith(OrderSuccessfullyPlaced value,
          $Res Function(OrderSuccessfullyPlaced) then) =
      _$OrderSuccessfullyPlacedCopyWithImpl<$Res>;
}

/// @nodoc
class _$OrderSuccessfullyPlacedCopyWithImpl<$Res>
    extends _$PlaceOrderStateCopyWithImpl<$Res>
    implements $OrderSuccessfullyPlacedCopyWith<$Res> {
  _$OrderSuccessfullyPlacedCopyWithImpl(OrderSuccessfullyPlaced _value,
      $Res Function(OrderSuccessfullyPlaced) _then)
      : super(_value, (v) => _then(v as OrderSuccessfullyPlaced));

  @override
  OrderSuccessfullyPlaced get _value => super._value as OrderSuccessfullyPlaced;
}

/// @nodoc

class _$OrderSuccessfullyPlaced implements OrderSuccessfullyPlaced {
  const _$OrderSuccessfullyPlaced();

  @override
  String toString() {
    return 'PlaceOrderState.orderSuccessfullyPlaced()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is OrderSuccessfullyPlaced);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() orderCanceled,
    required TResult Function() orderSuccessfullyPlaced,
    required TResult Function(String message) error,
  }) {
    return orderSuccessfullyPlaced();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
  }) {
    return orderSuccessfullyPlaced?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (orderSuccessfullyPlaced != null) {
      return orderSuccessfullyPlaced();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(OrderCanceled value) orderCanceled,
    required TResult Function(OrderSuccessfullyPlaced value)
        orderSuccessfullyPlaced,
    required TResult Function(Error value) error,
  }) {
    return orderSuccessfullyPlaced(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
  }) {
    return orderSuccessfullyPlaced?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (orderSuccessfullyPlaced != null) {
      return orderSuccessfullyPlaced(this);
    }
    return orElse();
  }
}

abstract class OrderSuccessfullyPlaced implements PlaceOrderState {
  const factory OrderSuccessfullyPlaced() = _$OrderSuccessfullyPlaced;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$PlaceOrderStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(Error(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Error implements Error {
  const _$Error(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PlaceOrderState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() orderCanceled,
    required TResult Function() orderSuccessfullyPlaced,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? orderCanceled,
    TResult Function()? orderSuccessfullyPlaced,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(OrderCanceled value) orderCanceled,
    required TResult Function(OrderSuccessfullyPlaced value)
        orderSuccessfullyPlaced,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(OrderCanceled value)? orderCanceled,
    TResult Function(OrderSuccessfullyPlaced value)? orderSuccessfullyPlaced,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements PlaceOrderState {
  const factory Error(String message) = _$Error;

  String get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
