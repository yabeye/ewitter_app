import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:ewitter_app/src/theme/pallet.dart';

import '../../../constants/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getBody() {
      switch (_page) {
        case 0:
          return Center(
              child: Text(
            "Home Screen!",
            style: boldTextStyle(size: 22, color: Colors.white),
          ));
        case 1:
          return Center(
              child: Text(
            "Explore Screen!",
            style: boldTextStyle(size: 22, color: Colors.white),
          ));
        case 2:
          return Center(
              child: Text(
            "Spaces Screen!",
            style: boldTextStyle(size: 22, color: Colors.white),
          ));
        case 3:
          return Center(
              child: Text(
            "Notifications Screen!",
            style: boldTextStyle(size: 22, color: Colors.white),
          ));
        case 4:
          return Center(
              child: Text(
            "Inbox Screen!",
            style: boldTextStyle(size: 22, color: Colors.white),
          ));

        default:
          return Center(
              child: Text(
            "Unknown Page!",
            style: boldTextStyle(size: 22, color: Colors.white),
          ));
      }
    }

    return Scaffold(
      appBar: appBar(),
      body: getBody(),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: KPallet.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 0 ? KAssets.homeFilledIcon : KAssets.homeOutlinedIcon,
              color: KPallet.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 1 ? KAssets.searchIconFilled : KAssets.searchIcon,
              color: KPallet.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 2
                  ? KAssets.microphoneFilledIcon
                  : KAssets.microphoneIcon,
              color: KPallet.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 3
                  ? KAssets.notificationFilledIcon
                  : KAssets.notificationOutlinedIcon,
              color: KPallet.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 4 ? KAssets.emailFilledIcon : KAssets.emailIcon,
              color: KPallet.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
