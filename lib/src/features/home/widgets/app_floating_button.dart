import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../common/theme/theme.dart';
import '../../../common/constants/constants.dart';

class AppFloatingButton extends StatelessWidget {
  final ValueNotifier<bool> isDialOpen;
  final VoidCallback onCreatePost;

  const AppFloatingButton({
    super.key,
    required this.isDialOpen,
    required this.onCreatePost,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeChild: const Icon(
        Icons.close,
        color: Colors.white,
      ),
      activeIcon: Icons.close,
      spacing: 3,
      openCloseDial: isDialOpen,
      spaceBetweenChildren: 4,
      iconTheme: const IconThemeData(size: 32, color: Colors.white),
      labelTransitionBuilder: (widget, animation) =>
          ScaleTransition(scale: animation, child: widget),
      // childrenButtonSize: const Size(40.0, 70.0),
      visible: true,
      overlayColor: KPalette.backgroundColor,
      overlayOpacity: 0.8,
      onOpen: () => debugPrint('Open new post'),
      onClose: () => debugPrint('Close new post'),
      useRotationAnimation: true,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      shape: const StadiumBorder(),
      children: [
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.newPostIcon,
            color: KPalette.primaryColor,
          ),
          backgroundColor: Colors.white,
          foregroundColor: KPalette.primaryColor,
          label: 'Eweet',
          labelStyle: const TextStyle(backgroundColor: Colors.transparent),
          visible: true,
          onTap: onCreatePost,
        ),
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.gifIcon,
            color: KPalette.primaryColor,
          ),
          backgroundColor: Colors.white,
          foregroundColor: KPalette.primaryColor,
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
            color: KPalette.primaryColor,
          ),
          backgroundColor: KPalette.whiteColor,
          foregroundColor: KPalette.primaryColor,
          label: 'Photos',
          onTap: () {
            toasty(context, "Posting a new photo ...");
          },
        ),
        SpeedDialChild(
          child: SvgPicture.asset(
            KAssets.microphoneIcon,
            color: KPalette.primaryColor,
          ),
          backgroundColor: KPalette.whiteColor,
          foregroundColor: KPalette.primaryColor,
          label: 'Spaces',
          onTap: () {
            toasty(context, "Going to space ...");
          },
        ),
      ],
      child: const Icon(Icons.add, color: KPalette.whiteColor),
    );
  }
}
