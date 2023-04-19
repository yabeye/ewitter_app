import 'package:ewitter_app/src/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ewitter_app/src/common/components/back_widget.dart';

import 'package:ewitter_app/src/common/theme/theme.dart';
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
              color: KPalette.primaryColor,
              borderRadius: radius(100),
            ),
            child: const CircularProgressIndicator(
              color: KPalette.whiteColor,
            ),
          )
        : (titleWidget ??
            SvgPicture.asset(
              KAssets.ewitterLogoTransparent,
              width: 50,
              height: 50,
            )),
    color: KPalette.backgroundColor,
    showBack: showBack,
    center: true,
    backWidget: backWidget ?? const BackWidget(),
  );
}

Widget customTextField(
  BuildContext context, {
  bool autoFocus = false,
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
    autoFocus: autoFocus,
    nextFocus: nextFocusNode,
    textFieldType: textFieldType ?? TextFieldType.NAME,
    errorThisFieldRequired:
        errorFieldRequired ?? "${labelText ?? "This field"} is required",
    textStyle: const TextStyle(color: KPalette.whiteColor),
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
