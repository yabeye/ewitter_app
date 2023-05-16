import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ewitter_app/src/common/theme/theme.dart';

// ignore: must_be_immutable
class SelectedItemWidget extends StatelessWidget {
  Decoration? decoration;
  double itemSize;
  bool isSelected;

  SelectedItemWidget(
      {super.key,
      this.decoration,
      this.itemSize = 12.0,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 18,
      width: 18,
      decoration: decoration ??
          boxDecorationDefault(
            color: isSelected ? KPalette.primaryColor : context.cardColor,
            border: Border.all(color: KPalette.primaryColor),
            shape: BoxShape.circle,
          ),
      child: isSelected
          ? Icon(Icons.check, color: Colors.white, size: itemSize)
          : const Offstage(),
    );
  }
}
