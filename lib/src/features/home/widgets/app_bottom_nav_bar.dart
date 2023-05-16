import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme/theme.dart';
import '../../../common/constants/constants.dart';

class AppBottomNavBar extends StatelessWidget {
  final int page;
  final void Function(int) onPageChange;

  const AppBottomNavBar({
    super.key,
    required this.page,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: KPalette.greyColor,
            width: 0.3,
          ),
        ),
      ),
      child: CupertinoTabBar(
        currentIndex: page,
        onTap: (pg) {
          onPageChange(pg);
        },
        backgroundColor: KPalette.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              page == 0 ? KAssets.homeFilledIcon : KAssets.homeOutlinedIcon,
              color: KPalette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              page == 1 ? KAssets.searchIconFilled : KAssets.searchIcon,
              color: KPalette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              page == 2 ? KAssets.microphoneFilledIcon : KAssets.microphoneIcon,
              color: KPalette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              page == 3
                  ? KAssets.notificationFilledIcon
                  : KAssets.notificationOutlinedIcon,
              color: KPalette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              page == 4 ? KAssets.emailFilledIcon : KAssets.emailIcon,
              color: KPalette.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
