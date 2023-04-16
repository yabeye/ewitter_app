import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  late final ValueNotifier<bool> _isDialOpen;

  bool visible = true;

  @override
  void initState() {
    _isDialOpen = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _isDialOpen.dispose();
    super.dispose();
  }

  void _onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  _onCreatePost() {
    toasty(context, "Navigate to CreateNewEweet Screen!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _getBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _getBody() {
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

  SpeedDial _buildFloatingActionButton() {
    return SpeedDial(
      activeChild: const Icon(
        Icons.close,
        color: Colors.white,
      ),

      activeIcon: Icons.close,
      spacing: 3,
      openCloseDial: _isDialOpen,
      spaceBetweenChildren: 4,
      iconTheme: const IconThemeData(size: 32, color: Colors.white),
      labelTransitionBuilder: (widget, animation) =>
          ScaleTransition(scale: animation, child: widget),
      // childrenButtonSize: const Size(40.0, 70.0),
      visible: visible,
      overlayColor: KPallet.backgroundColor,
      overlayOpacity: 0.8,
      onOpen: () => debugPrint('OPENING New POST'),
      onClose: () => debugPrint('CLOSING New POST'),
      useRotationAnimation: true,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      shape: const StadiumBorder(),
      children: [
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.newPostIcon,
            color: KPallet.primaryColor,
          ),
          backgroundColor: Colors.white,
          foregroundColor: KPallet.primaryColor,
          label: 'Eweet',
          labelStyle: const TextStyle(backgroundColor: Colors.transparent),
          visible: true,
          onTap: _onCreatePost,
        ),
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.gifIcon,
            color: KPallet.primaryColor,
          ),
          backgroundColor: Colors.white,
          foregroundColor: KPallet.primaryColor,
          label: 'Gif',
          labelStyle: const TextStyle(backgroundColor: Colors.transparent),
          visible: true,
          onTap: () {
            toasty(context, "Posting a gif from giphy ...");
          },
        ),
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.galleryIcon,
            color: KPallet.primaryColor,
          ),
          backgroundColor: KPallet.whiteColor,
          foregroundColor: KPallet.primaryColor,
          label: 'Photos',
          onTap: () {
            toasty(context, "Posting a new photo ...");
          },
        ),
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.microphoneIcon,
            color: KPallet.primaryColor,
          ),
          backgroundColor: KPallet.whiteColor,
          foregroundColor: KPallet.primaryColor,
          label: 'Spaces',
          onTap: () {
            toasty(context, "Going to space ...");
          },
        ),
      ],
      child: const Icon(Icons.add, color: KPallet.whiteColor),
    );
  }

  CupertinoTabBar _buildBottomNavigationBar() {
    return CupertinoTabBar(
      currentIndex: _page,
      onTap: _onPageChange,
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
            _page == 2 ? KAssets.microphoneFilledIcon : KAssets.microphoneIcon,
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
    );
  }
}
