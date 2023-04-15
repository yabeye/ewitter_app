import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constants/constants.dart';
import '../../theme/theme.dart';

class LogoLoader extends StatelessWidget {
  const LogoLoader({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: KPallet.primaryColor,
        borderRadius: radius(100),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(KAssets.ewitterLogo),
          SizedBox(
            child: !isLoading
                ? null
                : const CircularProgressIndicator(
                    color: KPallet.primaryColor,
                    strokeWidth: 8,
                  ),
          )
        ],
      ),
    );
  }
}
