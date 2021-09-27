import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/banner_model.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerItem extends StatelessWidget {
  final BannerModel banner;

  BannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final routerUtils = getItInstance<RouterUtils>();
        routerUtils.pushNamedRoot(context, Routes.productsScreen,arguments: banner);
        // Navigator.pushNamed(context, Routes.productsScreen ,arguments: banner);
      },
      child: CachedNetworkImage(
        imageUrl: banner.image!,
        fit: BoxFit.fill,
      ),
    );
  }
}
