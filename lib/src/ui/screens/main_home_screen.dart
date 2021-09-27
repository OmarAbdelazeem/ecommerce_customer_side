import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/banners/banners.dart';
import 'package:baqal/src/bloc/internet_connection/internet_connection.dart';
import 'package:baqal/src/bloc/products/products.dart';
import 'package:baqal/src/models/banner_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/notifiers/main_home_screen_provider.dart';
import 'package:baqal/src/notifiers/notification_provider.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/cart_icon.dart';
import 'package:baqal/src/ui/common/snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_bar_screens/account_screen.dart';
import 'navigation_bar_screens/cart_screen.dart';
import 'navigation_bar_screens/categories_screen.dart';
import 'navigation_bar_screens/search_screen.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final addToCartCubit = getItInstance<AddToCartCubit>();

  final internetConnectionCubit = getItInstance<InternetConnectionCubit>();

  final notificationProvider = getItInstance<NotificationProvider>();

  final languageProvider = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();

  List<Widget> navigationBarScreens = [
    CategoriesScreen(),
    SearchScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  void checkNotificationType(Map<String, dynamic> data) async {
    if (data['type'] == 'product') {
      final productsCubit = getItInstance<ProductsCubit>();
      ProductModel? product = await productsCubit.getProductData(data['id']);
      if (product != null)
        routerUtils.pushNamedRoot(context, Routes.productDetailsScreen,
            arguments: product);
      // Navigator.pushNamed(context, Routes.productDetailsScreen,
      //     arguments: product);
    } else if (data['type'] == 'banner') {
      final bannersCubit = getItInstance<BannersCubit>();
      BannerModel? banner = await bannersCubit.getBannerData(data['id']);
      if (banner != null)
        routerUtils.pushNamedRoot(context, Routes.productsScreen,
            arguments: banner);
      // Navigator.pushNamed(context, Routes.productsScreen, arguments: banner);
    } else if (data['type'] == 'order') {
      routerUtils.pushNamedRoot(context, Routes.orderDetailsScreen,
          arguments: data['id']);
      // Navigator.pushNamed(context, Routes.orderDetailsScreen,
      //     arguments: data['id']);
    }
  }

  void setUpNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('onMessage data is ${message.data}');
      print('onMessage notification is ${message.notification}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        Future.delayed(Duration(milliseconds: 1)).then((value) =>
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(notification.body!),
                  );
                }));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        checkNotificationType(message.data);
      }
    });

    if (notificationProvider.initialMessage != null) {
      checkNotificationType(notificationProvider.initialMessage.data);
    }
  }


  @override
  void initState() {
    super.initState();

    internetConnectionCubit.listenToInternetConnection();

    setUpNotifications();

    addToCartCubit.listenToCart();
  }


  @override
  void dispose() {
    print('internet controller disposed');
    internetConnectionCubit.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
      bloc: internetConnectionCubit,
      listener: (context, state) {
        state.when(
            idle: () {},
            noInternetConnection: () {
              print('connection failed');
              showSnackBar(
                  duration: Duration(days: 1),
                  title: languageProvider.getTranslated(
                      context, StringsConstants.connectionNotAvailable)!,
                  context: context);
            },
            connectedSuccessfully: () {
              print('internet connected');
              hideSnackBar(context);
            });
      },
      builder: (context, state) {
        return ProviderNotifier(
            child: (MainHomeScreenProvider mainHomeScreenProvider) {
              onWillPop() async {
                if (mainHomeScreenProvider.navigationIndex != 0) {
                  mainHomeScreenProvider.pageController.jumpToPage(0);
                  setState(() {
                    mainHomeScreenProvider.setNavigationIndex = 0;
                  });
                  return false;
                } else
                  return true;
              }

              void onTap(int index) {
                mainHomeScreenProvider.pageController.jumpToPage(index);
                setState(() {
                  mainHomeScreenProvider.setNavigationIndex = index;
                });
              }

              return WillPopScope(
                onWillPop: onWillPop,
                child: Scaffold(
                  body: PageView(
                    controller: mainHomeScreenProvider.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: navigationBarScreens,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                            mainHomeScreenProvider.navigationIndex == 0
                                ? Icons.home
                                : Icons.home_outlined,
                            size: 30),
                        label: languageProvider.getTranslated(
                            context, StringsConstants.home),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                            mainHomeScreenProvider.navigationIndex == 1
                                ? Icons.search
                                : Icons.search_outlined,
                            size: 30),
                        label: languageProvider.getTranslated(
                            context, StringsConstants.search),
                      ),
                      BottomNavigationBarItem(
                        icon: Stack(
                          children: <Widget>[
                            Center(
                                child: CartIcon(
                                  isOutlined:
                                  mainHomeScreenProvider.navigationIndex != 2,
                                )),
                          ],
                        ),
                        label: languageProvider.getTranslated(
                            context, StringsConstants.cart),
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                              mainHomeScreenProvider.navigationIndex == 3
                                  ? Icons.person
                                  : Icons.person_outline,
                              size: 30),
                          label: languageProvider.getTranslated(
                              context, StringsConstants.account)),
                    ],
                    onTap:onTap,
                    currentIndex: mainHomeScreenProvider.navigationIndex,
                  ),
                ),
              );
            });
      },
    );
  }
}
