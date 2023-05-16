import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../theme/theme.dart';

class CustomLinearStepper extends StatelessWidget {
  const CustomLinearStepper({
    super.key,
    required this.stepperList,
    required this.stepperIndex,
  });

  final List<String> stepperList;
  final int stepperIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stepperList[stepperIndex],
                style: boldTextStyle(
                  color: KPalette.whiteColor,
                ),
              ),
              Chip(
                label: Text(
                  "${(stepperIndex + 1).bitLength == 1 ? "0" : ""}${stepperIndex + 1} / ${stepperList.length.bitLength == 1 ? "0" : ""}${stepperList.length}",
                  style: boldTextStyle(size: body2Size),
                ),
                backgroundColor: KPalette.primaryColorLight,
              ),
            ],
          ),
          10.height,
          Stack(
            children: [
              Container(
                height: 10,
                width: context.width(),
                decoration: BoxDecoration(
                  color: KPalette.greyColor.withOpacity(.5),
                  borderRadius: radius(),
                ),
                child: Container(),
              ),
              Container(
                height: 10,
                width:
                    context.width() * ((stepperIndex + 1) / stepperList.length),
                decoration: BoxDecoration(
                  color: KPalette.primaryColor,
                  borderRadius: radius(),
                ),
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
