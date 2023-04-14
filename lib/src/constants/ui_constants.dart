import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:ewitter_app/src/theme/theme.dart';
import 'asset_constants.dart';

AppBar appBar({
  bool isLoading = false,
  Widget? leading,
  withNotification = true,
}) {
  return appBarWidget(
    "",
    titleWidget: isLoading
        ? Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: KPallet.primaryColor,
              borderRadius: radius(100),
            ),
            child: const CircularProgressIndicator(
              color: KPallet.whiteColor,
            ),
          )
        : SvgPicture.asset(
            KAssets.ewitterLogo,
            width: 50,
            height: 50,
          ),
    color: KPallet.backgroundColor,
    showBack: false,
    center: true,
  );
}
