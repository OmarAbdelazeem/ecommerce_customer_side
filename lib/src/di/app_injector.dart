import 'package:baqal/src/bloc/account_details/account_details_cubit.dart';
import 'package:baqal/src/bloc/addresses/addresses.dart';
import 'package:baqal/src/bloc/banners/banners.dart';
import 'package:baqal/src/bloc/check_user_data/check_user_data.dart';
import 'package:baqal/src/bloc/delivery_areas/delivery_areas_cubit.dart';
import 'package:baqal/src/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:baqal/src/bloc/main_categories/main_categories_cubit.dart';
import 'package:baqal/src/bloc/order_item/order_item.dart';
import 'package:baqal/src/bloc/sub_categories/sub_categories.dart';
import 'package:baqal/src/core/services/notification_service.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/categories_provider.dart';
import 'package:baqal/src/notifiers/delivery_areas_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/notifiers/main_home_screen_provider.dart';
import 'package:baqal/src/notifiers/notification_provider.dart';
import 'package:baqal/src/repository/algolia_repository.dart';
import 'package:baqal/src/repository/hive_repsitory.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/products/products_cubit.dart';
import 'package:baqal/src/bloc/cart_item/cart_item.dart';
import 'package:baqal/src/bloc/my_orders/my_orders_cubit.dart';
import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/bloc/place_order/place_order_cubit.dart';
import 'package:baqal/src/bloc/product_search/product_search.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

GetIt getItInstance = GetIt.I;

class AppInjector {
  static final AppInjector _singleton = AppInjector._internal();

  factory AppInjector() => _singleton;

  AppInjector._internal();

  static void create() {
    _initCubits();
    _initRepos();
    _initNotifiers();
    _initServices();
    _initRouter();
  }

  static _initRepos() {
    getItInstance.registerFactory(() => FirestoreRepository());
    getItInstance.registerFactory(() => FirebaseRepository());
    getItInstance.registerFactory(() => AlgoliaRepository());
    getItInstance.registerFactory(() => HiveRepository());
  }

  static _initServices() {
    getItInstance.registerFactory(() => NotificationService());
  }

  static _initRouter() {
    getItInstance.registerLazySingleton(() => RouterUtils());
  }

  static _initCubits() {
    getItInstance.registerFactory(() => AuthCubit());
    getItInstance.registerFactory(() => MainCategoriesCubit());
    getItInstance.registerFactory(() => SubCategoriesCubit());
    getItInstance.registerFactory(() => BannersCubit());
    getItInstance.registerFactory(() => OrderCubit());

    getItInstance.registerFactory(() => AddressesCubit());
    getItInstance.registerLazySingleton(() => InternetConnectionCubit());

    getItInstance.registerFactory(() => AddToCartCubit());
    getItInstance.registerFactory(() => AccountDetailsCubit());
    getItInstance.registerFactory(() => ProductSearchCubit());
    getItInstance.registerFactory(() => CartItemCubit());
    getItInstance.registerFactory(() => PlaceOrderCubit());
    getItInstance.registerFactory(() => ProductsCubit());
    getItInstance.registerFactory(() => MyOrdersCubit());
    getItInstance.registerFactory(() => CheckUserDataCubit());
    getItInstance.registerFactory(() => DeliveryAreasCubit());
  }

  static void _initNotifiers() {
    getItInstance.registerLazySingleton(() => CartStatusProvider());
    getItInstance.registerLazySingleton(() => AccountProvider());
    getItInstance.registerLazySingleton(() => CategoriesProvider());
    getItInstance.registerLazySingleton(() => AddressesProvider());
    getItInstance.registerLazySingleton(() => DeliveryAreasProvider());
    getItInstance.registerLazySingleton(() => MainHomeScreenProvider());
    getItInstance.registerLazySingleton(() => NotificationProvider());
    getItInstance.registerLazySingleton(() => LanguageProvider());
  }
}
