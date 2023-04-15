import 'package:ewitter_app/src/common/components/back_widget.dart';
import 'package:ewitter_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:ewitter_app/src/theme/theme.dart';
import 'asset_constants.dart';

AppBar appBar({
  bool isLoading = false,
  Widget? leading,
  Widget? titleWidget,
  withNotification = true,
  Widget? backWidget,
  bool showBack = false,
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
        : (titleWidget ??
            SvgPicture.asset(
              KAssets.ewitterLogo,
              width: 50,
              height: 50,
            )),
    color: KPallet.backgroundColor,
    showBack: showBack,
    center: true,
    backWidget: backWidget ?? const BackWidget(),
  );
}

Widget customTextField(
  BuildContext context, {
  String? labelText,
  TextEditingController? controller,
  FocusNode? focus,
  FocusNode? nextFocusNode,
  TextFieldType? textFieldType,
  String? errorFieldRequired,
  Iterable<String>? autoFillHints,
  dynamic Function(String)? onFieldSubmitted,
  String? Function(String?)? validator,
  bool isPassword = false,
}) {
  return AppTextField(
    controller: controller,
    focus: focus,
    nextFocus: nextFocusNode,
    textFieldType: textFieldType ?? TextFieldType.NAME,
    errorThisFieldRequired:
        errorFieldRequired ?? "${labelText ?? "This field"} is required",
    textStyle: const TextStyle(color: KPallet.whiteColor),
    isPassword: isPassword,
    suffixPasswordVisibleWidget: !isPassword
        ? null
        : KAssets.showIcon.iconImage(size: 10).paddingAll(14),
    suffixPasswordInvisibleWidget: !isPassword
        ? null
        : KAssets.hideIcon.iconImage(size: 10).paddingAll(14),
    decoration: inputDecoration(
      context,
      labelText: labelText,
    ),
    autoFillHints: autoFillHints,
    onFieldSubmitted: onFieldSubmitted ?? (s) {},
    validator: validator,
  );
}
