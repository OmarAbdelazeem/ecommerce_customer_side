import 'package:baqal/src/bloc/check_user_data/check_user_data.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/models/banner_model.dart';
import 'package:baqal/src/models/name_field.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/routes/routes_arguments.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/screens/add_or_edit_address_screen.dart';
import 'package:baqal/src/ui/screens/add_user_name_screen.dart';
import 'package:baqal/src/ui/screens/check_status_screen.dart';
import 'package:baqal/src/ui/screens/checkout_screen.dart';
import 'package:baqal/src/ui/screens/connection_error_screen.dart';
import 'package:baqal/src/ui/screens/login_screen.dart';
import 'package:baqal/src/ui/screens/main_home_screen.dart';
import 'package:baqal/src/ui/screens/my_address_screen.dart';
import 'package:baqal/src/ui/screens/my_orders_screen.dart';
import 'package:baqal/src/ui/screens/navigation_bar_screens/account_screen.dart';
import 'package:baqal/src/ui/screens/navigation_bar_screens/cart_screen.dart';
import 'package:baqal/src/ui/screens/navigation_bar_screens/categories_screen.dart';
import 'package:baqal/src/ui/screens/navigation_bar_screens/search_screen.dart';
import 'package:baqal/src/ui/screens/order_confirmation.dart';
import 'package:baqal/src/ui/screens/order_details_screen.dart';
import 'package:baqal/src/ui/screens/otp_login_screen.dart';
import 'package:baqal/src/ui/screens/product_details_screen.dart';
import 'package:baqal/src/ui/screens/products_screen.dart';
import 'package:baqal/src/ui/screens/splash_screen.dart';
import 'package:baqal/src/ui/screens/undefined_view_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splashScreen:
      return MaterialPageRoute(
          builder: (context) => SplashScreen());

    case Routes.connectionErrorScreen:
      return MaterialPageRoute(builder: (context) => ConnectionErrorScreen());

    case Routes.accountScreen:
      return MaterialPageRoute(builder: (context) => AccountScreen());
    case Routes.cartScreen:
      return MaterialPageRoute(builder: (context) => CartScreen());
    case Routes.categoriesScreen:
      return MaterialPageRoute(builder: (context) => CategoriesScreen());
    case Routes.searchScreen:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    case Routes.addOrEditAddressScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as Address : null;
      return MaterialPageRoute(
          builder: (context) => AddOrEditAddressScreen(
                editAddress: arguments,
              ));
    case Routes.addUserNameScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as bool : null;
      return MaterialPageRoute(
          builder: (context) => AddUserNameScreen(
                newName: arguments!,
              ));

    case Routes.productsScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as BannerModel : null;
      return MaterialPageRoute(
          builder: (context) => ProductsScreen(
                banner: arguments,
              ));
    // case Routes.checkStatusScreen:
    //   var arguments =
    //       settings.arguments != null ? settings.arguments as String : null;
    //   return MaterialPageRoute(
    //       builder: (context) => CheckStatusScreen(arguments!));
    case Routes.checkOutScreen:
      return MaterialPageRoute(builder: (context) => CheckOutScreen());
    case Routes.loginScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as bool : null;
      return MaterialPageRoute(
          builder: (context) => LoginScreen(
                isForUpdatePhone: arguments!,
              ));
    case Routes.mainHomeScreen:
      return MaterialPageRoute(builder: (context) => MainHomeScreen());
    case Routes.myAddressScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as bool : null;
      return MaterialPageRoute(
          builder: (context) => MyAddressScreen(
                selectAddress: arguments!,
              ));
    case Routes.myOrdersScreen:
      return MaterialPageRoute(builder: (context) => MyOrdersScreen());
    case Routes.orderConfirmationScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as String : null;
      return MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(arguments!));
    case Routes.orderDetailsScreen:
      var arguments =
          settings.arguments != null ? settings.arguments as String : null;
      return MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(arguments!));

    case Routes.otpLoginScreen:
      var arguments = settings.arguments != null
          ? settings.arguments as OtpLoginScreenArguments
          : null;
      return MaterialPageRoute(
          builder: (context) => OtpLoginScreen(arguments!));

    case Routes.productDetailsScreen:
      var arguments = settings.arguments != null
          ? settings.arguments as ProductModel
          : null;
      return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(arguments!));

    case Routes.searchScreen:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    default:
      var arguments =
          settings.arguments != null ? settings.arguments as String : null;
      return MaterialPageRoute(
          builder: (context) => UndefinedViewScreen(
                name: arguments,
              ));
  }
}
