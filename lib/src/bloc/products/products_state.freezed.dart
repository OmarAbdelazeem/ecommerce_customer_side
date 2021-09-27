// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProductsStateTearOff {
  const _$ProductsStateTearOff();

  Idle idle() {
    return const Idle();
  }

  FetchingFirstList fetchingFirstList() {
    return const FetchingFirstList();
  }

  Loaded loaded(List<ProductModel> products) {
    return Loaded(
      products,
    );
  }

  ErrorWhenFetchingNextList errorWhenFetchingNextList(
      String error, List<ProductModel> products) {
    return ErrorWhenFetchingNextList(
      error,
      products,
    );
  }

  FetchingNextList fetchingNextList() {
    return const FetchingNextList();
  }

  RunOutOfData runOutOfData() {
    return const RunOutOfData();
  }

  Error error(String error) {
    return Error(
      error,
    );
  }
}

/// @nodoc
const $ProductsState = _$ProductsStateTearOff();

/// @nodoc
mixin _$ProductsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
          ProductsState value, $Res Function(ProductsState) then) =
      _$ProductsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._value, this._then);

  final ProductsState _value;
  // ignore: unused_field
  final $Res Function(ProductsState) _then;
}

/// @nodoc
abstract class $IdleCopyWith<$Res> {
  factory $IdleCopyWith(Idle value, $Res Function(Idle) then) =
      _$IdleCopyWithImpl<$Res>;
}

/// @nodoc
class _$IdleCopyWithImpl<$Res> extends _$ProductsStateCopyWithImpl<$Res>
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
    return 'ProductsState.idle()';
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
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
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
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class Idle implements ProductsState {
  const factory Idle() = _$Idle;
}

/// @nodoc
abstract class $FetchingFirstListCopyWith<$Res> {
  factory $FetchingFirstListCopyWith(
          FetchingFirstList value, $Res Function(FetchingFirstList) then) =
      _$FetchingFirstListCopyWithImpl<$Res>;
}

/// @nodoc
class _$FetchingFirstListCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res>
    implements $FetchingFirstListCopyWith<$Res> {
  _$FetchingFirstListCopyWithImpl(
      FetchingFirstList _value, $Res Function(FetchingFirstList) _then)
      : super(_value, (v) => _then(v as FetchingFirstList));

  @override
  FetchingFirstList get _value => super._value as FetchingFirstList;
}

/// @nodoc

class _$FetchingFirstList implements FetchingFirstList {
  const _$FetchingFirstList();

  @override
  String toString() {
    return 'ProductsState.fetchingFirstList()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is FetchingFirstList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return fetchingFirstList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return fetchingFirstList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (fetchingFirstList != null) {
      return fetchingFirstList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return fetchingFirstList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return fetchingFirstList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (fetchingFirstList != null) {
      return fetchingFirstList(this);
    }
    return orElse();
  }
}

abstract class FetchingFirstList implements ProductsState {
  const factory FetchingFirstList() = _$FetchingFirstList;
}

/// @nodoc
abstract class $LoadedCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) then) =
      _$LoadedCopyWithImpl<$Res>;
  $Res call({List<ProductModel> products});
}

/// @nodoc
class _$LoadedCopyWithImpl<$Res> extends _$ProductsStateCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(Loaded _value, $Res Function(Loaded) _then)
      : super(_value, (v) => _then(v as Loaded));

  @override
  Loaded get _value => super._value as Loaded;

  @override
  $Res call({
    Object? products = freezed,
  }) {
    return _then(Loaded(
      products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

class _$Loaded implements Loaded {
  const _$Loaded(this.products);

  @override
  final List<ProductModel> products;

  @override
  String toString() {
    return 'ProductsState.loaded(products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loaded &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(products);

  @JsonKey(ignore: true)
  @override
  $LoadedCopyWith<Loaded> get copyWith =>
      _$LoadedCopyWithImpl<Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return loaded(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return loaded?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements ProductsState {
  const factory Loaded(List<ProductModel> products) = _$Loaded;

  List<ProductModel> get products => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadedCopyWith<Loaded> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorWhenFetchingNextListCopyWith<$Res> {
  factory $ErrorWhenFetchingNextListCopyWith(ErrorWhenFetchingNextList value,
          $Res Function(ErrorWhenFetchingNextList) then) =
      _$ErrorWhenFetchingNextListCopyWithImpl<$Res>;
  $Res call({String error, List<ProductModel> products});
}

/// @nodoc
class _$ErrorWhenFetchingNextListCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res>
    implements $ErrorWhenFetchingNextListCopyWith<$Res> {
  _$ErrorWhenFetchingNextListCopyWithImpl(ErrorWhenFetchingNextList _value,
      $Res Function(ErrorWhenFetchingNextList) _then)
      : super(_value, (v) => _then(v as ErrorWhenFetchingNextList));

  @override
  ErrorWhenFetchingNextList get _value =>
      super._value as ErrorWhenFetchingNextList;

  @override
  $Res call({
    Object? error = freezed,
    Object? products = freezed,
  }) {
    return _then(ErrorWhenFetchingNextList(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

class _$ErrorWhenFetchingNextList implements ErrorWhenFetchingNextList {
  const _$ErrorWhenFetchingNextList(this.error, this.products);

  @override
  final String error;
  @override
  final List<ProductModel> products;

  @override
  String toString() {
    return 'ProductsState.errorWhenFetchingNextList(error: $error, products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorWhenFetchingNextList &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(products);

  @JsonKey(ignore: true)
  @override
  $ErrorWhenFetchingNextListCopyWith<ErrorWhenFetchingNextList> get copyWith =>
      _$ErrorWhenFetchingNextListCopyWithImpl<ErrorWhenFetchingNextList>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return errorWhenFetchingNextList(this.error, products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return errorWhenFetchingNextList?.call(this.error, products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (errorWhenFetchingNextList != null) {
      return errorWhenFetchingNextList(this.error, products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return errorWhenFetchingNextList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return errorWhenFetchingNextList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (errorWhenFetchingNextList != null) {
      return errorWhenFetchingNextList(this);
    }
    return orElse();
  }
}

abstract class ErrorWhenFetchingNextList implements ProductsState {
  const factory ErrorWhenFetchingNextList(
      String error, List<ProductModel> products) = _$ErrorWhenFetchingNextList;

  String get error => throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorWhenFetchingNextListCopyWith<ErrorWhenFetchingNextList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchingNextListCopyWith<$Res> {
  factory $FetchingNextListCopyWith(
          FetchingNextList value, $Res Function(FetchingNextList) then) =
      _$FetchingNextListCopyWithImpl<$Res>;
}

/// @nodoc
class _$FetchingNextListCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res>
    implements $FetchingNextListCopyWith<$Res> {
  _$FetchingNextListCopyWithImpl(
      FetchingNextList _value, $Res Function(FetchingNextList) _then)
      : super(_value, (v) => _then(v as FetchingNextList));

  @override
  FetchingNextList get _value => super._value as FetchingNextList;
}

/// @nodoc

class _$FetchingNextList implements FetchingNextList {
  const _$FetchingNextList();

  @override
  String toString() {
    return 'ProductsState.fetchingNextList()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is FetchingNextList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return fetchingNextList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return fetchingNextList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (fetchingNextList != null) {
      return fetchingNextList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return fetchingNextList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return fetchingNextList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (fetchingNextList != null) {
      return fetchingNextList(this);
    }
    return orElse();
  }
}

abstract class FetchingNextList implements ProductsState {
  const factory FetchingNextList() = _$FetchingNextList;
}

/// @nodoc
abstract class $RunOutOfDataCopyWith<$Res> {
  factory $RunOutOfDataCopyWith(
          RunOutOfData value, $Res Function(RunOutOfData) then) =
      _$RunOutOfDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$RunOutOfDataCopyWithImpl<$Res> extends _$ProductsStateCopyWithImpl<$Res>
    implements $RunOutOfDataCopyWith<$Res> {
  _$RunOutOfDataCopyWithImpl(
      RunOutOfData _value, $Res Function(RunOutOfData) _then)
      : super(_value, (v) => _then(v as RunOutOfData));

  @override
  RunOutOfData get _value => super._value as RunOutOfData;
}

/// @nodoc

class _$RunOutOfData implements RunOutOfData {
  const _$RunOutOfData();

  @override
  String toString() {
    return 'ProductsState.runOutOfData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RunOutOfData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return runOutOfData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return runOutOfData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (runOutOfData != null) {
      return runOutOfData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return runOutOfData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return runOutOfData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (runOutOfData != null) {
      return runOutOfData(this);
    }
    return orElse();
  }
}

abstract class RunOutOfData implements ProductsState {
  const factory RunOutOfData() = _$RunOutOfData;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$ProductsStateCopyWithImpl<$Res>
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
    return 'ProductsState.error(error: $error)';
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
    required TResult Function() fetchingFirstList,
    required TResult Function(List<ProductModel> products) loaded,
    required TResult Function(String error, List<ProductModel> products)
        errorWhenFetchingNextList,
    required TResult Function() fetchingNextList,
    required TResult Function() runOutOfData,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
    TResult Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? fetchingFirstList,
    TResult Function(List<ProductModel> products)? loaded,
    TResult Function(String error, List<ProductModel> products)?
        errorWhenFetchingNextList,
    TResult Function()? fetchingNextList,
    TResult Function()? runOutOfData,
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
    required TResult Function(FetchingFirstList value) fetchingFirstList,
    required TResult Function(Loaded value) loaded,
    required TResult Function(ErrorWhenFetchingNextList value)
        errorWhenFetchingNextList,
    required TResult Function(FetchingNextList value) fetchingNextList,
    required TResult Function(RunOutOfData value) runOutOfData,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(FetchingFirstList value)? fetchingFirstList,
    TResult Function(Loaded value)? loaded,
    TResult Function(ErrorWhenFetchingNextList value)?
        errorWhenFetchingNextList,
    TResult Function(FetchingNextList value)? fetchingNextList,
    TResult Function(RunOutOfData value)? runOutOfData,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements ProductsState {
  const factory Error(String error) = _$Error;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
