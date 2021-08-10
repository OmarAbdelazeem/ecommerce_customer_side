import 'package:baqal/src/bloc/location/location_cubit.dart';
import 'package:baqal/src/bloc/main_categories/main_categories_cubit.dart';
import 'package:baqal/src/bloc/selected_main_category/selected_main_category_cubit.dart';
import 'package:baqal/src/notifiers/categories_provider.dart';
import 'package:baqal/src/notifiers/navigation_provider.dart';
import 'package:baqal/src/notifiers/selected_category_provider.dart';
import 'package:baqal/src/repository/location_service.dart';
import 'package:get_it/get_it.dart';
import 'package:baqal/src/bloc/add_account_details/add_account_details.dart';
import 'package:baqal/src/bloc/add_address/add_address.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/address_card/address_card.dart';
import 'package:baqal/src/bloc/all_products/all_product_cubit.dart';
import 'package:baqal/src/bloc/cart_item/cart_item.dart';
import 'package:baqal/src/bloc/home_page/home_page_cubit.dart';
import 'package:baqal/src/bloc/my_address/my_address.dart';
import 'package:baqal/src/bloc/my_orders/my_orders_cubit.dart';
import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/bloc/place_order/place_order_cubit.dart';
import 'package:baqal/src/bloc/product_search/product_search.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/main_screen_provider.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

GetIt getItInstance = GetIt.I;

class AppInjector {

  static final AppInjector _singleton = AppInjector._internal();

  factory AppInjector() => _singleton;

  AppInjector._internal();


  static const String dealOfTheDay = "deal_of_the_day";
  static const String topProducts = "top_products";
  static const String onSale = "on_sale";

  static void create() {
    _initCubits();
    _initRepos();
    _initNotifiers();
  }

  static _initRepos() {
    getItInstance.registerFactory(() => FirestoreRepository());
    getItInstance.registerFactory(() => FirebaseRepository());
    // _injector.registerFactory(() => LocationService());
  }

  static _initCubits() {
    getItInstance.registerFactory(() => AuthCubit());
    getItInstance.registerLazySingleton(() => MainCategoriesCubit());
    // _injector.registerLazySingleton(() => LocationCubit());

    // _injector.registerLazySingleton(() => null)
    // _injector.registerLazySingleton(() => SelectedMainCategoryCubit());
    getItInstance.registerFactory(() => ProductDataCubit(),
        instanceName: dealOfTheDay);
    getItInstance.registerFactory(() => ProductDataCubit(),
        instanceName: topProducts);
    getItInstance.registerFactory(() => ProductDataCubit(), instanceName: onSale);

    getItInstance.registerFactory(() => AddToCartCubit());
    getItInstance.registerFactory(() => AddAccountDetailsCubit());
    getItInstance.registerFactory(() => ProductSearchCubit());
    getItInstance.registerFactory(() => CartItemCubit());
    // _injector.registerFactory(() => PaymentCubit());
    getItInstance.registerFactory(() => PlaceOrderCubit());
    getItInstance.registerLazySingleton(() => AllProductCubit());
    getItInstance.registerFactory(() => MyAddressCubit());
    getItInstance.registerFactory(() => AddAddressCubit());
    getItInstance.registerFactory(() => AddressCardCubit());
    getItInstance.registerFactory(() => MyOrdersCubit());
  }

  static void _initNotifiers() {
    getItInstance.registerLazySingleton(() => CartStatusProvider());
    getItInstance.registerLazySingleton(() => MainScreenProvider());
    getItInstance.registerLazySingleton(() => AccountProvider());
    getItInstance.registerLazySingleton(() => CategoriesProvider());
    getItInstance.registerLazySingleton(() => NavigationProvider());
    getItInstance.registerLazySingleton(() => SelectedCategoryProvider());
  }
}
